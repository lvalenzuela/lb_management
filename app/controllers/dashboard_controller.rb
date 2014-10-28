class DashboardController < ApplicationController
	protect_from_forgery
	before_filter :check_authentication
	layout "dashboard"

	def courses_list
		@filters = {}
		if params[:filter]
			if params[:filter][:show_hidden]
				courses = DashboardCoursesV.all()
				@filters[:show_hidden] = true
			else
				courses = DashboardCoursesV.where(:visible => 1)
			end
			if params[:filter][:show_late]
				max_attendance_delay = CourseAlarmParameter.find_by_param_name("max_attendance_delay").value.to_i
				courses = courses.where("(current_booked_sessions - current_taken_sessions) > #{max_attendance_delay}")
				@filters[:show_late] = true
			end
		else
			courses = DashboardCoursesV.where(:visible => 1)
		end

		if params[:search]
			f_courses = courses.where("coursename like '%#{params[:search]}%'")
		else
			f_courses = courses
		end
		@courses_list = f_courses.order("courseid ASC").page(params[:page]).per(10)
	end

	def course
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
		@course = MoodleCourseV.find_by_moodleid(params[:id])
		@template_sessions = CourseTemplateSession.where(:course_template_id => @course.course_template_id)
		#obtencion del contenido de las sesiones
		@taken_sessions = StudentAttendanceReport.where("courseid = #{params[:id]} and created_at = curdate()").group("sessionid").order("sessiondate ASC").map{|s| s.description}
		@course_observations = CourseObservation.where(:course_id => params[:id])
		if @students_info.blank?
			@institution = ""
		else
			@institution = StudentV.find(@students_info.first().userid).institution
		end
	end

	def generate_detailed_course_report
		course = MoodleCourseV.find_by_moodleid(params[:courseid])

		respond_to do |format|
			format.pdf do
				pdf = DetailedCourseReportPdf.new(course,params[:institution],view_context)
				send_data pdf.render, :filename => course.coursename+"_test.pdf", :type => "application/pdf"
			end
		end
	end

	def create_course_observation
		c = CourseObservation.create(course_observation_params)
		redirect_to :action => :course, :id => c.course_id
	end

	def edit_course_observation
		@course_obs = CourseObservation.where(:id => params[:id], :course_id => params[:courseid]).first()
	end

	def update_course_observation
		c_obs = CourseObservation.find(params[:course_observation][:id])
		c_obs.update_attributes(course_observation_params)
		redirect_to :action => :course, :id => c_obs.course_id
	end

	def student
		@course_grades = StudentGradesReport.where("userid = #{params[:studentid]} and courseid = #{params[:courseid]} and created_at = curdate()").order("sortorder ASC")
		@grade_categories = @course_grades.where("categoryname != '?' and itemname is null")
		@general_attendance = StudentGeneralAttendanceReport.where("userid = #{params[:studentid]} and courseid = #{params[:courseid]} and created_at = curdate()")
		@student_info = StudentV.find(params[:studentid])
		@other_courses = StudentGradesReport.select("distinct(courseid)").where("userid = #{@student_info.id} and courseid != #{params[:courseid]} and created_at = curdate()")
		@final_grade = @course_grades.where(:categoryname => "?", :itemname => nil).first()
		@student_attendance = StudentAttendanceReport.where("courseid = #{params[:courseid]} and userid = #{params[:studentid]} and created_at = curdate()" ).order("sessionid ASC")
	end

	def teachers_list
		if params[:search]
			@teachers = TeacherV.all().page(params[:page]).per(10)
		else
			@teachers = TeacherV.all().page(params[:page]).per(10)
		end
	end

	def teacher
		@user = TeacherV.find(params[:id])
		courses_list = MoodleRoleAssignationV.where(:userid => params[:id]).map{|c| c.courseid}
		if params[:filter]
			if params[:filter][:show_hidden]
				@show_hidden = true
				c = DashboardCoursesV.where(:courseid => courses_list)
			else
				c = DashboardCoursesV.where(:courseid => courses_list, :visible => 1)
			end
		else
			c = DashboardCoursesV.where(:courseid => courses_list, :visible => 1)
		end

		if params[:search]
			f_c = c.where("coursename like '%#{params[:search]}%'")
		else
			f_c = c
		end
		@courses = f_c.order("courseid ASC").page(params[:page]).per(10)
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

	def alarm_courses
		case params[:opt]
		when "delayed_sessions"
			courses_list = delayed_sessions_courses
			@active = "delayed_sessions"
		when "low_grades"
			courses_list = low_grades_courses
			@active = "low_grades"
		else #low_attendance
			courses_list = low_attendance_courses
			@active = "low_attendance"
		end
		@courses = courses_list.page(params[:page]).per(10)
	end

	private

	def low_attendance_courses
		min_attendance = CourseAlarmParameter.where(:param_name => "min_attendance").first().value.to_i
		return DashboardCoursesV.where("(avg_attendance_ratio*100) < #{min_attendance} and visible = 1")
	end

	def low_grades_courses
		min_grade = CourseAlarmParameter.where(:param_name => "approve_grade").first().value
		min_grade = grade_to_points(min_grade)
		return DashboardCoursesV.where("mean_grade < #{min_grade} and visible = 1 and gradetype = 2")
	end

	def delayed_sessions_courses
		max_delay = CourseAlarmParameter.where(:param_name => "max_attendance_delay").first().value.to_i
		return DashboardCoursesV.where("(current_booked_sessions - current_taken_sessions) > #{max_delay} and visible = 1")
	end

	def grade_to_points(grade)
		grade_array = grade.split(".")
		return (grade[0].to_i - 1) * 10 + grade[1].to_i + 1
	end

	def course_observation_params
		params.require(:course_observation).permit(:course_id, :user_id, :subject, :message, :attachment)
	end

    def check_authentication
        if current_user.nil?
          redirect_to :controller => "users", :action => "index"
        elsif current_user.system_role_id > 2
        	render "users/not_authorized"
        end
    end
end
