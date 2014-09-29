class DashboardController < ApplicationController
	protect_from_forgery
	before_filter :check_authentication
	layout "dashboard"

	def courses_list
		@filters = []
		if params[:search]
			courses = DashboardCoursesV.where("coursename like '%#{params[:search]}%'")
		else
			courses = DashboardCoursesV.all()
		end
		#filtros
		if params[:filter]
			if params[:filter][:hide_invisible]
				f_courses = courses.where(:visible => 1)
				@hide_invis = true
			else
				f_courses = courses
			end
			@courses_list = f_courses.order("courseid ASC").page(params[:page]).per(10)
		else
			#todos los cursos encontrados
			@courses_list = courses.order("courseid ASC").page(params[:page]).per(10)
		end
	end

	def course
		@courseid = params[:id]
		@students_info = StudentGradesReport.joins("as sgr
						inner join student_general_attendance_reports as sgar
						on sgr.userid = sgar.userid and sgr.courseid = sgar.courseid 
						and sgr.created_at = curdate() and sgar.created_at = curdate()
						and sgr.courseid = #{params[:id]}").select("
						sgr.userid,
						sgr.courseid,
						sgr.finalgrade,
						sgr.gradetype,
						sgar.present_sessions,
						sgar.absent_sessions,
						sgar.total_sessions,
						sgar.created_at").where("sgr.categoryname = '?' and sgr.itemname is null").group("sgr.userid").order("sgr.courseid ASC")
		@user_roles = MoodleRoleAssignationV.where(:courseid => params[:id]).order("roleid ASC")
		@attendance_reports = CourseAttendanceReport.where("courseid = #{params[:id]} and created_at = curdate()").first()
		@course_grade = CourseGradesReport.where("courseid = #{params[:id]} and created_at = curdate() and categoryname = '?' and itemname is null").first()
		moodle_course = MoodleCourseV.find_by_moodleid(params[:id])
		@template_sessions = CourseTemplateSession.where(:course_template_id => moodle_course.course_template_id)
		if @template_sessions.blank?
			@template_id = nil
		else
			@template_id = @template_sessions.first().course_template_id
		end
		#obtencion del contenido de las sesiones
		ts = StudentAttendanceReport.where("courseid = #{params[:id]} and created_at = curdate()").group("sessionid").order("sessiondate ASC")
		@taken_sessions = []
		ts.each do |sess|
			@taken_sessions << sess.description
		end
	end

	def student
		@course_grades = StudentGradesReport.where("userid = #{params[:studentid]} and courseid = #{params[:courseid]} and created_at = curdate()").order("sortorder ASC")
		@grade_categories = @course_grades.where("categoryname != '?' and itemname is null")
		@general_attendance = StudentGeneralAttendanceReport.where("userid = #{params[:studentid]} and courseid = #{params[:courseid]} and created_at = curdate()")
		@student_info = UserReport.select("userid, firstname, lastname, concat(firstname, ' ', lastname) as name, institution, department, username").where(:userid => params[:studentid]).first()
		@other_courses = StudentGradesReport.select("distinct(courseid)").where("userid = #{@student_info.userid} and courseid != #{params[:courseid]} and created_at = curdate()")
		@final_grade = @course_grades.where(:categoryname => "?", :itemname => nil).first()
		@student_attendance = StudentAttendanceReport.where("courseid = #{params[:courseid]} and userid = #{params[:studentid]} and created_at = curdate()" ).order("sessionid ASC")
	end

	def teachers_list
		if params[:search]
			@teachers = User.joins("inner join moodle_role_assignation_vs as mra
							on users.id = mra.userid").select("users.*,
															count(distinct mra.courseid) as courses").where("
															mra.roleid in(9,4)
															and (users.firstname like '%#{params[:search]}%' or users.lastname like '%#{params[:search]}%')").group("users.id").page(params[:page]).per(10)
		else
			@teachers = User.joins("inner join moodle_role_assignation_vs as mra
							on users.id = mra.userid").select("users.*,
															count(distinct mra.courseid) as courses").where("
															mra.roleid in(9,4)").group("users.id").page(params[:page]).per(10)
		end
	end

	def teacher
		@user = User.find(params[:id])
		@courses = MoodleRoleAssignationV.joins("as mra inner join moodle_course_vs as mc
						on mra.courseid = mc.moodleid
						left join course_attendance_reports as car
						on mra.courseid = car.courseid
						left join course_grades_reports as cgr
						on car.courseid = cgr.courseid 
						and car.created_at = cgr.created_at
						and car.created_at = curdate()").select("mra.roleid, 
																mra.rolename, 
																mra.courseid,
																mc.coursename,
																car.current_booked_sessions,
																car.current_taken_sessions,
																car.total_sessions,
																car.last_taken_session_date,
																car.avg_attendance_ratio,
																cgr.mean_grade,
																cgr.std_dev_grade,
																cgr.gradetype,
																car.created_at").where("mra.roleid in (9,4) and mra.userid = #{params[:id]}").group("mra.courseid").order("mra.roleid ASC").page(params[:page]).per(10)
	end

	def configuration
		parameters = CourseAlarmParameter.all()
		@min_grade = parameters.find_by_param_name("approve_grade").value
		@min_attendance = parameters.find_by_param_name("min_attendance").value
		@max_attendance_delay = parameters.find_by_param_name("max_attendance_delay").value
	end

	def update_alarm_parameters
		grade = CourseAlarmParameter.find_by_param_name("approve_grade")
		grade.value = params[:min_grade]
		grade.save!

		attendance = CourseAlarmParameter.find_by_param_name("min_attendance")
		attendance.value = params[:min_attendance]
		attendance.save!

		max_att_delay = CourseAlarmParameter.find_by_param_name("max_attendance_delay")
		max_att_delay.value = params[:max_attendance_delay]
		max_att_delay.save!
		redirect_to :action => :configuration
	end

	private

    def check_authentication
        if current_user.nil?
          redirect_to :controller => "users", :action => "index"
        elsif current_user.system_role_id > 2
        	render "users/not_authorized"
        end
    end
end
