class ReportsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard", except:[:index]
	include ReportsHelper
	require 'zip'
	
	def index
		if !session[:user_id].nil?
			redirect_to :action => :clients
		else
			redirect_to :controller => "main", :action => "index"
		end
	end

	def clients
		@clients = get_client_list(params[:institution_name])
	end

	def courses
		@groups = find_course_by_institution(params[:institution],params[:group_filter])
		@selected = params[:group_filter]
	end

	def members
		@members = find_group_members(params[:institution],params[:fullname],params[:filter])

		@group = {}
		if params[:filter].to_i == 2
			@group = {:type => "Departamento", 
				:name => @members.first().department, 
				:institution => params[:institution], 
				:fullname => params[:fullname],
				:filter => params[:filter]}
		elsif params[:filter].to_i == 1
			@group = {:type => "Curso", 
				:name => @members.first().coursename,
				:institution => params[:institution], 
				:fullname => params[:fullname],
				:filter => params[:filter]}
		end
	end

	def historical
		@courses = UserReport.select("courseid, coursename, count(distinct created_at) as reportnum").group("courseid")
		@reports = nil #UserReport.select("*, count(distinct userid) as alumnos").group("courseid, created_at")
	end	

	def reports_for_course
		@reports = UserReport.select("coursename, courseid, institution, created_at, count(distinct userid) as alumnos").where(:courseid => params[:id]).group("courseid, created_at").order("created_at DESC")

		respond_to do |format|
			format.js
		end
	end

	def course_groups
		@groups = MoodleGroup.all()
		if params[:id]
			@courses = MoodleCourse.joins("inner join moodle_group_assignations as mga
							on mga.m_courseid = moodle_courses.moodleid
							and mga.groupid = #{params[:id]}")
			@selected_group = MoodleGroup.find(params[:id])
		else
			@courses = nil
		end
	end

	def reporte_preliminar

	end

	def show
	
	end

	def bulk_user_reports
		members = find_group_members(params[:institution], params[:fullname], params[:filter])
		
		filename = params[:institution]+"_"+params[:fullname]+"_"+Date.today().to_s+".zip"

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

	def group_report
		courses = find_course_by_institution(params[:institution], params[:filter])

		respond_to do |format|
			format.html
			format.pdf do
				pdf = GroupReportPdf.new(params[:institution],params[:fullname], params[:filter],view_context)
	  			send_data pdf.render, filename: courses.first().institution+" - "+params[:fullname]+" - "+Date.today().to_s+".pdf",
					                   type:"application/pdf"
			end
		end
	end

	private

	def check_authentication
	    if session[:user_id].nil?
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
					pdf_filename = member.firstname.gsub(/[áéíóúñ]/, '-')+"_"+member.lastname.gsub(/[áéíóúñ]/, '-')+"_"+Date.today().to_s+"_"+Time.now().to_s+".pdf"
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
