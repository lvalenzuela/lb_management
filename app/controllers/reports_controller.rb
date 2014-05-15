class ReportsController < ApplicationController
	protect_from_forgery
	include ReportsHelper
	
	def index
		if !session[:user_id].nil?
			redirect_to :action => :courses
		else
			redirect_to :controller => "main", :action => "index"
		end
	end

	def courses
		if params[:course_name].nil?
			@courses = Course.where("id >= 0").order("id asc").page(params[:page]).per(10)
		else
			@courses = Course.where("lower(fullname) like '%#{params[:course_name]}%'").page(params[:page]).per(10)
		end
	end

	def course_members
		@course = Course.where(:id => params[:course_id])
		@course_members = Course.find_by_sql("	select
													user.id as userid,
													user.firstname as firstname,
													user.lastname as lastname,
													user.institution as institution,
													role.name as rol,
													role.shortname as role_shortname,
													role.id as roleid
												from mdl_role_assignments as r_assign
												inner join mdl_role as role
													on r_assign.roleid = role.id
												inner join mdl_user as user
													on r_assign.userid = user.id
												where
													r_assign.contextid in (select id from mdl_context as context where contextlevel = 50 and instanceid = #{params[:course_id]})
												order by roleid asc")
	end

	def reporte_preliminar
		@user = User.where(:id => params[:user_id])
		@course = Course.where(:id => params[:course_id])
		attendance = Attforblock.find_by_sql("	select
													count(distinct(t.date)) as asistencias
												from
												(select
													att_log.studentid as studentid,
													att_stat.acronym as acronym,
													att_stat.description as description,
													from_unixtime(att_log.timetaken) as date
												from mdl_attendance_log as att_log
												inner join mdl_attendance_statuses as att_stat
													on att_log.statusid = att_stat.id
												where
													att_log.sessionid in (	select
																		id
																	from mdl_attendance_sessions
																	where
																		lasttakenby != 0 
																		and attendanceid in(select id from mdl_attforblock where course = #{@course.first().id}))) as t")

	end

	def show
	end

	def generate_report
		user = User.where(:id => params[:user_id])

		respond_to do |format|
			format.html
			format.pdf do
				pdf = DocumentPdf.new(params,view_context)
	  			send_data pdf.render,  filename: user.first().firstname+"_"+user.first().lastname+"_"+Date.today().to_s+".pdf",
					                   type:"application/pdf"
			end
		end
	end

end
