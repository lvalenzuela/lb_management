class ReportsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard", except:[:index]
	require 'zip'
	
	def index
		if !current_user.id.nil?
			redirect_to :action => :clients
		else
			redirect_to :controller => "main", :action => "index"
		end
	end

	def clients
		@clients = get_client_list(params[:institution])
	end

	def courses
		if params[:group_filter] && params[:group_filter].to_i == 2
			#Listado por departamento
			groups_list = UserReport.joins("right join moodle_course_vs as courses
											on user_reports.courseid = courses.moodleid
											and courses.visible = 1").where("lower(institution) = lower('#{params[:institution]}') 
											and user_reports.created_at = (select max(created_at) from user_reports)").select("department, institution, count(distinct userid) as alumnos").group("department")
		else
			#Listado por curso
			groups_list = UserReport.joins("right join moodle_course_vs as courses
											on user_reports.courseid = courses.moodleid
											and courses.visible = 1").where("lower(institution) = lower('#{params[:institution]}')
											and user_reports.created_at = (select max(created_at) from user_reports)").select("courseid, user_reports.coursename as coursename, institution, count(distinct userid) as alumnos").group("courseid")
		end
		@groups = groups_list.page(params[:page]).per(10)
		@institution = params[:institution]
		@selected = params[:group_filter]
	end

	def course_members
		@members = UserReport.where(:courseid => params[:courseid], :created_at => last_report_date).group("userid")
		@course = MoodleCourseV.find_by_moodleid(@members.first().courseid)
		@institution = @members.first().institution
	end

	def department_members
		@members = UserReport.where(:institution => params[:institution], :department => params[:department], :created_at => last_report_date).group("userid")
		@department_name = params[:department]
		@institution = params[:institution]
	end

	def historical
		if params[:search]
			courselist = UserReport.where("coursename like '%#{params[:search]}%'").select("courseid, coursename, count(distinct created_at) as reportnum").group("courseid")
		else
			courselist = UserReport.select("courseid, coursename, count(distinct created_at) as reportnum").group("courseid")
		end
		@courses = courselist
		@reports = nil #UserReport.select("*, count(distinct userid) as alumnos").group("courseid, created_at")
	end	

	def reports_for_course
		@reports = UserReport.select("coursename, courseid, institution, created_at, count(distinct userid) as alumnos").where(:courseid => params[:id]).group("courseid, created_at").order("created_at DESC")

		respond_to do |format|
			format.js
		end
	end

	def show
	
	end

	def course_bulk_user_reports
		members = UserReport.where(:courseid => params[:courseid], :created_at => last_report_date).group("userid")
		aux = members.first() #utilizado para obtener datos generales
		filename = aux.institution+"_"+aux.coursename+"_"+l(Date.today(),:format => "%d-%m-%Y")+".zip"
		zip_data = generate_reports_folder(members, filename)
		send_data(zip_data, :type => 'application/zip', :filename => filename)
	end

	def department_bulk_user_reports
		members = UserReport.where(:institution => params[:institution], :department => params[:department], :created_at => last_report_date).group("userid")
		aux = members.first() #utilizado para obtener datos generales
		filename = aux.institution+"_"+aux.department+"_"+l(Date.today(),:format => "%d-%m-%Y")+".zip"
		zip_data = generate_reports_folder(members, filename)
		send_data(zip_data, :type => 'application/zip', :filename => filename)
	end

	def user_report
		user = UserReport.where(:userid => params[:user_id]).first()

		respond_to do |format|
			format.html
			format.pdf do
				pdf = StudentReportPdf.new(params[:user_id],params[:course_id],view_context)
	  			send_data pdf.render, filename: user.firstname+"_"+user.lastname+"_"+Date.today().to_s+".pdf",
	  								 type: "application/pdf"
			end
		end
	end

	def course_report
		course = MoodleCourseV.find_by_moodleid(params[:courseid])
		if params[:date]
			date = Date.parse(params[:date])
		else
			date = last_report_date
		end
		respond_to do |format|
			format.html
			format.pdf do
				pdf = CourseReportPdf.new(course, params[:institution], date, view_context)
				send_data pdf.render, filename: params[:institution]+"_"+course.coursename+"_"+l(date,:format => "%d-%m-%Y")+".pdf",
					                   type:"application/pdf"
			end
		end
	end

	def department_report
		date = last_report_date
		respond_to do |format|
			format.html
			format.pdf do
				pdf = DepartmentReportPdf.new(params[:department], params[:institution], date, view_context)
				send_data pdf.render, filename: params[:institution]+"_"+params[:department]+"_"+l(date,:format => "%d-%m-%Y")+".pdf",
					                   type:"application/pdf"
			end
		end
	end

	def course_groups

		case params[:opt]
		when "department"
			@active = "department"
			if params[:institution]
				@groups = CourseGroupReport.select("distinct department").where(:institution => params[:institution])
				@institution = params[:institution]
				if params[:department]
					@reports = CourseGroupReport.where(:institution => params[:institution], :department => params[:department]).group("created_at").order("created_at DESC")
					@selected_group = params[:department]
				end
			else
				@institution_list = CourseGroupReport.select("institution, count(distinct userid) as users, count(distinct groupid) as groups").group("institution")
			end
		else
			@active = "groups"
			@groups = MoodleGroup.all()
			if params[:id]
				@reports = CourseGroupReport.where(:groupid => params[:id]).group("created_at").order("created_at DESC")
				@selected_group = MoodleGroup.find(params[:id])
			end
		end
	end

	def course_group_report
		group = MoodleGroup.find(params[:id])
		date = params[:date] ? params[:date] : nil

		respond_to do |format|
			format.html
			format.pdf do
				pdf = CourseGroupReportPdf.new(group, date, view_context)
				send_data pdf.render, filename: group.groupname+"-"+Date.today.to_s+".pdf",
										type: "application/pdf"
			end
		end
	end

	def institution_department_report
		date = params[:date] ? params[:date] : nil

		respond_to do |format|
			format.html
			format.pdf do
				pdf = InstitutionDepartmentReportPdf.new(params[:institution], params[:department], date, view_context)
				send_data pdf.render, filename: params[:institution]+"-"+params[:department]+"-"+Date.today.to_s+".pdf",
										type: "application/pdf"
			end
		end
	end

	private

	def get_client_list(institution)
		if institution.nil?
			@clients = UserReport.select("institution, 
										count(distinct department) as departments, 
										count(distinct courseid) as courses, 
										count(distinct userid) as users").where("institution <> '' and institution is not null").group(:institution)
		else
			@clients = UserReport.select("institution, 
										count(distinct department) as departments, 
										count(distinct courseid) as courses, 
										count(distinct userid) as users").where("institution like '%#{institution}%'").group(:institution)
		end
	end

	def last_report_date
		return UserReport.all().order("created_at DESC").first().created_at
	end

	def check_authentication
	    if current_user.nil?
	      redirect_to :controller => "users", :action => "index"
	    end
	end

	def generate_reports_folder(members, filename)
		
		tmp_reports_path = "tmp_reports"
		temp_file_zip = Tempfile.new(filename)
		temp_files = []
		begin
			Zip::OutputStream.open(temp_file_zip) { |zos| }

			Zip::File.open(temp_file_zip.path, Zip::File::CREATE) do |zip|
				members.each do |member|
					pdf_filename = member.firstname.gsub(/[áéíóúñ]/, '-')+"_"+member.lastname.gsub(/[áéíóúñ]/, '-')+"_"+l(Date.today(),:format => "%d-%m-%Y")+".pdf"
					temp_files << pdf_filename
					pdf = StudentReportPdf.new(member.userid, member.courseid,view_context)
					pdf.render_file(Rails.root.join("app","assets",tmp_reports_path,pdf_filename))
					zip.add(pdf_filename, Rails.root.join("app","assets",tmp_reports_path,pdf_filename))
				end
			end

			zip_data = File.read(temp_file_zip.path)			
		ensure
			temp_file_zip.close
			temp_file_zip.unlink
		end
		#Eliminar los archivos generados
		temp_files.each do |filename|
			File.delete(Rails.root.join("app","assets",tmp_reports_path,filename)) if File.exists?(Rails.root.join("app","assets",tmp_reports_path,filename))
		end
		return zip_data
	end
end
