class UsersController < ApplicationController
	protect_from_forgery
	require 'bcrypt'
	layout :resolve_layout

	#modulo con funciones para copiar cursos desde moodle a summit
	include CourseDetails 
	
	def index
	    #Si el usuario ya esta logeado, se redirige al panel de control
	    if !current_user.nil?
	      redirect_to :controller => "main", :action => 'index'
	    end
	end

	def search
		
	end

	def login
	    user = UserV.find_by_username(params[:username])
	    if user.blank? || user.nil?
	      flash[:notice] = "Nombre de usuario incorrecto, por favor vuelve a intentarlo"
	      redirect_to :action => :index
	      #Permitir el ingreso sólo de usuarios de Longbourn.
	    elsif !user.username.end_with?("@longbourn.cl")
	      flash[:notice] = "Usuario no autorizado para ingresar al sistema"
	      redirect_to :action => "index" 
	    else
			fixed_pass = user.password
			fixed_pass[2] = "a" #se reemplaza de 'y' a 'a' para que se reconozca (blowfish)
			password = BCrypt::Password.new(user.password)
			if password == params[:password]
				if params[:remember_me]
					cookies.permanent[:auth_token] = User.find(user.id).check_auth_token
				else
					cookies[:auth_token] = User.find(user).check_auth_token
				end
				redirect_to root_path
			else
				flash[:notice] = "Contraseña incorrecta, por favor vuelve a intentarlo."
				redirect_to :action => :index
			end
	    end
	end

	def logout
	    cookies.delete(:auth_token)
	    redirect_to :action => "index"
	end

	def user_profile
		@user = current_user
		@user_area_roles = get_user_area_roles(@user.id)
	end

	def change_profile_picture
		user = User.find(current_user.id)
		user.avatar = params[:avatar]
		user.save!
		redirect_to :action => :user_profile
	end

	def my_calendar
		@user = current_user
		@availability = UserDisponibility.where(:user_id => @user.id)
		all_courses = MoodleRoleAssignationV.where(:userid => @user.id).map{|c| c.courseid}
		course_ids = MoodleCourseV.where(:moodleid => all_courses, :visible => 1).map{|c| c.moodleid}
        moodle_sessions = MoodleCourseSessionV.joins("as mcs inner join moodle_course_vs as courses
                                                on mcs.courseid = courses.moodleid").where("
                                                mcs.courseid in (?)",course_ids).select("
                                                                                        mcs.*,
                                                                                        courses.coursename").order("courses.coursename")
        gon.events = []
    	moodle_sessions.each do |s|
            #sesiones de los cursos asignados en moodle
            gon.events << {
                "title" => s.coursename,
                "start" => s.session_date,
                "allDay" => false,
                "backgroundColor" => "#0073b7", #azul
                "borderColor" => "#0073b7"
            }
        end
        commerce_courses = Course.where(:main_teacher_id => @user.id, :moodleid => nil, :course_status_id => [1,2,4]).map{|c| c.id}
        comm_sessions = CourseSession.where(:commerce_course_id => commerce_courses)
        comm_sessions.each do |cs|
            gon.events << {
                #sesiones de cursos del sistema que no se han registrado aun en moodle
                "title" => Course.find(cs.commerce_course_id).coursename,
                "start" => cs.startdatetime,
                "allDay" => false,
                "backgroundColor" => "#f39c12", #amarillo
                "borderColor" => "#f39c12"
            }
        end
	end

	def my_courses_alarms
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
		@courses = courses_list.where(:courseid => my_courses_list).page(params[:page]).per(10)
	end

	def my_courses
		@filters = {}
		@user = current_user
		if params[:filter]
			if params[:filter][:show_hidden]
				@courses = DashboardCoursesV.where(:courseid => my_courses_list)
				@filters[:show_hidden] = true
			else
				@courses = DashboardCoursesV.where(:courseid => my_courses_list, :visible => 1)
			end
		else
			@courses = DashboardCoursesV.where(:courseid => my_courses_list, :visible => 1)
		end
	end

	def show_course
		if check_own_course(params[:courseid])
			@course = MoodleCourseV.find_by_moodleid(params[:courseid])
			@students_info = StudentGradesReport.joins("as sgr
							inner join student_general_attendance_reports as sgar
							on sgr.userid = sgar.userid and sgr.courseid = sgar.courseid 
							and sgr.created_at = curdate() and sgar.created_at = curdate()
							and sgr.courseid = #{@course.moodleid}").select("
							sgr.userid,
							sgr.courseid,
							sgr.finalgrade,
							sgr.gradetype,
							sgar.present_sessions,
							sgar.absent_sessions,
							sgar.total_sessions,
							sgar.created_at").where("sgr.categoryname = '?' and sgr.itemname is null").group("sgr.userid").order("sgr.courseid ASC")
			@user_roles = MoodleRoleAssignationV.where(:courseid => @course.moodleid).order("roleid ASC")
			@attendance_reports = CourseAttendanceReport.where("courseid = #{@course.moodleid} and created_at = curdate()").first()
			@course_grade = CourseGradesReport.where("courseid = #{@course.moodleid} and created_at = curdate() and categoryname = '?' and itemname is null").first()
			@template_sessions = CourseTemplateSession.where(:course_template_id => @course.course_template_id)
			#obtencion del contenido de las sesiones
			@session_content_pages = StudentAttendanceReport.where("courseid = #{params[:courseid]} and created_at = curdate()").group("sessionid").order("sessiondate ASC").map{|s| s.pagenum}
			@course_observations = CourseObservation.where(:course_id => @course.moodleid)
			#para generacion de reportes
			if @students_info.blank?
				@institution = ""
			else
				@institution = StudentV.find(@students_info.first().userid).institution
			end
			@page_offset = calc_template_page_offset(@session_content_pages, @course.id, @template_sessions)
		else
			redirect_to :action => :my_courses
		end
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

	def register_course_details
		@moodle_course = MoodleCourseV.find_by_moodleid(params[:moodleid])
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
	end

	def create_course_details
		@course_details = Course.create(course_details_params)
		if @course_details.valid?
			@course_details.course_status_id = 3 #curso en desarrollo
			@course_details.end_date = replicate_moodle_course_sessions(@course_details.moodleid,@course_details.id)
			@course_details.main_teacher_id = get_teacher_for_moodle_course(@course_details.moodleid)
			@course_details.students_qty = get_students_qty_for_moodle_course(@course_details.moodleid)
			@course_details.save!
			redirect_to :action => :show_course, :courseid => @course_details.moodleid
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
	        render :register_course_details
		end
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
			#El resto de los atributos del curso no se modifican
			#debido a que el formulario de edicion no permite modificarlos
			redirect_to :action => :show_course, :courseid => params[:course_details][:moodleid]
		else
			@moodle_course = MoodleCourseV.find_by_moodleid(params[:course_details][:moodleid])
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
		redirect_to :action => :show_course, :courseid => course_details.moodleid
	end

	def show_student
		if check_own_course(params[:courseid])
			@course_grades = StudentGradesReport.where("userid = #{params[:studentid]} and courseid = #{params[:courseid]} and created_at = curdate()").order("sortorder ASC")
			@grade_categories = @course_grades.where("categoryname != '?' and itemname is null")
			@general_attendance = StudentGeneralAttendanceReport.where("userid = #{params[:studentid]} and courseid = #{params[:courseid]} and created_at = curdate()")
			@student_info = StudentV.find(params[:studentid])
			@other_courses = StudentGradesReport.select("distinct(courseid)").where("userid = #{@student_info.id} and courseid != #{params[:courseid]} and created_at = curdate()")
			@final_grade = @course_grades.where(:categoryname => "?", :itemname => nil).first()
			@student_attendance = StudentAttendanceReport.where("courseid = #{params[:courseid]} and userid = #{params[:studentid]} and created_at = curdate()" ).order("sessionid ASC")
		else
			redirect_to :action => :my_courses
		end
	end

	def create_teacher_course_observation
		c = CourseObservation.create(course_observation_params)
		redirect_to :action => :show_course, :courseid => c.course_id
	end

	def update_teacher_course_observation
		c_obs = CourseObservation.find(params[:course_observation][:id])
		c_obs.update_attributes(course_observation_params)
		redirect_to :action => :show_course, :courseid => c_obs.course_id
	end

	def edit_teacher_course_observation
		if check_own_course(params[:courseid])
			@course_obs = CourseObservation.where(:id => params[:id], :course_id => params[:courseid]).first()
		else
			redirect_to :action => :my_courses
		end
	end

	private

	def course_details_params
		params.require(:course_details).permit(:moodleid, :coursename, :description, :location_id, :course_type_id, :students_qty, :zoho_product_id, :course_template_id, :mode, :course_level_id, :classroom_matching_id, :start_date)
	end

	def my_courses_list
		return MoodleRoleAssignationV.where(:userid => current_user.id, :roleid => [4,9]).map{|u| u.courseid}
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

	def check_own_course(course)
		my_courses = MoodleRoleAssignationV.where(:userid => current_user.id).group(:courseid).map{|c| c.courseid}
		if my_courses.include?(course.to_i)
			return true
		else
			return false
		end
	end

	def user_disponibility_params
		params.require(:user_disponibility).permit(:user_id, :day_number, :start_time, :end_time)
	end

	def resolve_layout
		case action_name
		when "index"
			"login_layout"
		else
			"dashboard"
		end
	end

	def get_user_area_roles(user_id)
		#Se identifican todas las areas del sistema
		contexts = Context.where(:typeid => 2)
		roles = RoleAssignation.where(:userid => user_id, :contextid => contexts.map{|c| c.id})
		return roles
	end
end
