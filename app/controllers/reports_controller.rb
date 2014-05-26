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
		if params[:institution_name].nil?
			@clients = find_institutions(nil)
		else
			@clients = find_institutions(params[:institution_name])
		end
	end

	def courses
		@groups = find_course_by_institution(params[:institution], params[:group_filter])
		@selected = params[:group_filter]
	end

	def members
		@members = find_members(params[:institution], params[:fullname], params[:filter])
		
		@group = {}
		if params[:filter] == "2"
			@group = {:type => "Departamento", 
				:name => @members.first().department, 
				:institution => params[:institution], 
				:fullname => params[:fullname],
				:filter => params[:filter]}
		elsif params[:filter] == "1"
			@group = {:type => "Curso", 
				:name => @members.first().course_fullname,
				:institution => params[:institution], 
				:fullname => params[:fullname],
				:filter => params[:filter]}
		end
	end
	

	def reporte_preliminar

	end

	def show
	
	end

	def bulk_user_reports
		members = find_members(params[:institution], params[:fullname], params[:filter])
		
		filename = params[:institution]+"_"+params[:fullname]+"_"+Date.today().to_s+".zip"

		zip_data = generate_reports_folder(members, filename)
		
		send_data(zip_data, :type => 'application/zip', :filename => filename)

	end

	def user_report
		user = User.where(:id => params[:user_id])

		respond_to do |format|
			format.html
			format.pdf do
				pdf = StudentReportPdf.new(params,view_context)
	  			send_data pdf.render, filename: user.first().firstname+"_"+user.first().lastname+"_"+Date.today().to_s+".pdf",
					                   type:"application/pdf",
					                   disposition: "inline"
			end
		end
	end

	def group_report
		courses = find_course_by_institution(params[:institution], params[:filter])

		respond_to do |format|
			format.html
			format.pdf do
				pdf = GroupReportPdf.new(params[:institution],params[:fullname], params[:filter],view_context)
	  			send_data pdf.render, filename: courses.first().institution+"_"+Date.today().to_s+".pdf",
					                   type:"application/pdf"
			end
		end
	end

	private

	def check_authentication
	    if session[:user_id].nil?
	      redirect_to :controller => "main", :action => "index"
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
					pdf_filename = member.firstname.gsub(/[áéíóúñ]/, '-')+"_"+member.lastname.gsub(/[áéíóúñ]/, '-')+"_"+Date.today().to_s+".pdf"
					temp_files << pdf_filename
					params = {:user_id => member.userid, :course_id => member.courseid}
					pdf = StudentReportPdf.new(params,view_context)
					pdf.render_file(tmp_reports_path+"/"+pdf_filename)
					zip.add(pdf_filename, Rails.root.join(tmp_reports_path,pdf_filename))
				end
			end

			zip_data = File.read(temp_file_zip.path)			
		ensure
			temp_file_zip.close
			temp_file_zip.unlink
		end
		#Eliminar los archivos generados
		temp_files.each do |filename|
			File.delete(Rails.root.join(tmp_reports_path,filename)) if File.exists?(Rails.root.join(tmp_reports_path,filename))
		end
		return zip_data
	end
end
