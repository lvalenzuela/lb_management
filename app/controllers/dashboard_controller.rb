class DashboardController < ApplicationController
	protect_from_forgery
	before_filter :check_authentication
	layout "dashboard"

	#modulo con funciones para copiar cursos desde moodle a summit
	include CourseDetails 

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
		@session_content_pages = StudentAttendanceReport.where("courseid = #{params[:id]} and created_at = curdate()").group("sessionid").order("sessiondate ASC").map{|s| s.pagenum}
		@course_observations = CourseObservation.where(:course_id => params[:id])
		if @students_info.blank?
			@institution = ""
		else
			@institution = StudentV.find(@students_info.first().userid).institution
		end
		@page_offset = calc_template_page_offset(@session_content_pages, @course.id, @template_sessions)
	end

    def template_selector_options
        @templates = CourseTemplate.where(:course_level_id => params[:courselevel], :deleted => 0)
        respond_to do |format|
            format.js
        end
    end

    def product_selector_options
        @products = CourseModeZohoProductMap.where(:enabled => true, :course_mode_id => params[:coursemode])
        respond_to do |format|
            format.js
        end
    end

    def classroom_matching_selector_options
    	#si se selecciona la sede de coronel pereira, se dan opciones de classroom matchings.
    	#en otro caso, el arreglo se deja nulo
    	if params[:courselocation].to_i == 1 #sede coronel pereira
        	@classroom_matchings = ClassroomMatching.where("id not in (?) and enabled = 1", [0])
        else
        	@classroom_matchings = nil
        end
        respond_to do |format|
            format.js
        end
    end

	def new_course_details
		@moodle_course = MoodleCourseV.find_by_moodleid(params[:courseid])
		@course_details = Course.new()

        @locations = Location.all()
    	@types = CourseType.all()
    	@course = Course.new()
        @course_levels = CourseLevel.all()
        @modes = CourseMode.where(:enabled => true)
        @templates = nil
        #classroom_matchings
        used_matchings = Course.where("'#{@moodle_course.start_date}' between start_date and end_date and course_status_id in (2,3)").map{|c| c.classroom_matching_id}
        @classroom_matchings = ClassroomMatching.where("id not in (?) and enabled = 1",used_matchings.nil? ? used_matchings : [0])
        @summit_courses = Course.where(:moodleid => nil, :course_status_id => [2,3])
	end

	def create_course_details
		@course_details = Course.create(course_details_params)
		if @course_details.valid?
			@course_details.course_status_id = 3 #curso en desarrollo
			@course_details.end_date = replicate_moodle_course_sessions(@course_details.moodleid,@course_details.id)
			@course_details.main_teacher_id = get_teacher_for_moodle_course(@course_details.moodleid)
			@course_details.students_qty = get_students_qty_for_moodle_course(@course_details.moodleid)
			@course_details.save!
			redirect_to :action => :course, :id => @course_details.moodleid
		else
			@moodle_course = MoodleCourseV.find_by_moodleid(params[:course_details][:moodleid])
	        @locations = Location.all()
	    	@types = CourseType.all()
	    	@course = Course.new()
	        @course_levels = CourseLevel.all()
	        @modes = CourseMode.where(:enabled => true)
	        @templates = nil
	        #classroom_matchings
	        used_matchings = Course.where("'#{@moodle_course.start_date}' between start_date and end_date and course_status_id in (2,3)").map{|c| c.classroom_matching_id}
	        @classroom_matchings = ClassroomMatching.where("id not in (?) and enabled = 1",used_matchings.nil? ? used_matchings : [0])
	        @summit_courses = Course.where(:moodleid => nil, :course_status_id => [2,3])
	        render :new_course_details
		end
	end

	def pair_summit_moodle_course
		summit_course = Course.find(params[:summit_course_id])
		summit_course.moodleid = params[:moodle_id]
		summit_course.save!
		redirect_to :action => :course, :id => params[:moodle_id]
	end

	def edit_course_details
		@moodle_course = MoodleCourseV.find_by_moodleid(params[:moodleid])
		@course_details = Course.find(@moodle_course.summitid)
		@locations = Location.all()
		@types = CourseType.all()
		@course_levels = CourseLevel.all()
		@modes = CourseMode.all()
		#cosas que se pueden editar
		@templates = CourseTemplate.where(:course_level_id => @course_details.course_level_id, :deleted => 0)
		@products = CourseModeZohoProductMap.where(:enabled => true, :course_mode_id => @course_details.mode)
		if @course_details.location_id == 1
			@classroom_matchings = ClassroomMatching.where("id not in (?) and enabled = 1", [0])
		else
			@classroom_matchings = nil
		end
	end

	def update_course_details
		@course_details = Course.find(params[:course_details][:id])
		@course_details.update_attributes(course_details_params)
		if @course_details.valid?
			#el resto de los atributos no se actualiza
			redirect_to :action => :course, :id => @course_details.moodleid
		else
			@moodle_course = MoodleCourseV.find_by_moodleid(@course_details.moodleid)
			@locations = Location.all()
			@types = CourseType.all()
			@course_levels = CourseLevel.all()
			@modes = CourseMode.all()
			#cosas que se pueden editar
			@templates = CourseTemplate.where(:course_level_id => @course_details.course_level_id, :deleted => 0)
			@products = CourseModeZohoProductMap.where(:enabled => true, :course_mode_id => @course_details.mode)
			if @course_details.location_id == 1
				@classroom_matchings = ClassroomMatching.where("id not in (?) and enabled = 1", [0])
			else
				@classroom_matchings = nil
			end
			render :edit_course_details
		end
	end

	def update_course_calendar
		course_details = Course.find(params[:id])
		clear_course_sessions(course_details.moodleid, course_details.id)
		#si cambian las sesiones en moodle, tambien cambiara la fecha de termino del curso
		course_details.end_date = replicate_moodle_course_sessions(course_details.moodleid,course_details.id)
		course_details.save!
		redirect_to :action => :course, :id => course_details.moodleid
	end

	def generate_detailed_course_report
		course = MoodleCourseV.find_by_moodleid(params[:courseid])

		respond_to do |format|
			format.pdf do
				pdf = DetailedCourseReportPdf.new(course,params[:institution],view_context)
				send_data pdf.render, :filename => course.coursename+".pdf", :type => "application/pdf"
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

	def generate_detailed_student_report
		course = MoodleCourseV.find_by_moodleid(params[:courseid])
		student = StudentV.find(params[:studentid])

		respond_to do |format|
			format.pdf do
				pdf = DetailedStudentReportPdf.new(course,student,params[:institution],view_context)
				send_data pdf.render, :filename => student.name+"_"+course.coursename+".pdf", :type => "application/pdf"
			end
		end
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
		courses_list = MoodleRoleAssignationV.where(:userid => params[:id], :roleid => [4,9]).map{|c| c.courseid}
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
		@max_page_offset = parameters.find_by_param_name("max_page_offset").value
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

		max_page_offset = CourseAlarmParameter.find_by_param_name("max_page_offset")
		max_page_offset.value = params[:max_page_offset]
		max_page_offset.save!
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
		when "offset_content"
			courses_list = offset_content_courses
			@active = "offset_content"
		else #"low_attendance"
			courses_list = low_attendance_courses
			@active = "low_attendance"
		end
		@courses = courses_list.page(params[:page]).per(10)
	end

	def alarm_teachers
		@lp_courses = alarm_courses_list
		@teachers = TeacherV.where(:id => low_performance_teachers).page(params[:page]).per(10)
	end

	def teacher_low_performance
		@user = TeacherV.find(params[:userid])
		lp_courses = MoodleRoleAssignationV.where(:userid => @user.id, :courseid => alarm_courses_list, :roleid => [4,9]).map{|c| c.courseid}
		@courses = DashboardCoursesV.where(:courseid => lp_courses).page(params[:page]).per(10)
	end

	private

	def course_details_params
		params.require(:course_details).permit(:moodleid, :coursename, :description, :location_id, :course_type_id, :students_qty, :zoho_product_id, :course_template_id, :mode, :course_level_id, :classroom_matching_id, :start_date)
	end

	def alarm_courses_list
		courses = low_attendance_courses.map{|c| c.courseid}
		courses << low_grades_courses.where("courseid not in (?)",courses).map{|c| c.courseid}
		courses << delayed_sessions_courses.where("courseid not in (?)",courses).map{|c| c.courseid}
		courses << offset_content_courses.where("courseid not in (?)", courses).map{|c| c.courseid}
		return courses.flatten
	end

	def low_performance_teachers
		teachers = MoodleRoleAssignationV.where("courseid in (?) and roleid in (9,4)",alarm_courses_list).map{|u| u.userid}
		return teachers
	end

	def low_attendance_courses
		min_attendance = CourseAlarmParameter.where(:param_name => "min_attendance").first().value.to_i
		return DashboardCoursesV.where("(avg_attendance_ratio*100) < #{min_attendance} and visible = 1")
	end

	def low_grades_courses
		min_grade = CourseAlarmParameter.where(:param_name => "approve_grade").first().value
		min_grade = grade_to_points(min_grade)
		return DashboardCoursesV.where("mean_grade < #{min_grade} and visible = 1 and gradetype = 2")
	end

	def offset_content_courses
		max_offset_pages = CourseAlarmParameter.where(:param_name => "max_page_offset").first.value
		return DashboardCoursesV.where("last_visited_page = #{max_offset_pages} and visible = 1 and gradetype = 2")
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
