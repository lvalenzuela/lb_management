class UsersController < ApplicationController
	protect_from_forgery
	require 'bcrypt'
	layout :resolve_layout
	
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
        commerce_courses = Course.where(:main_teacher_id => @user.id, :moodleid => nil).map{|c| c.id}
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

	def my_courses
		@filters = {}
		@user = current_user
		my_courses = MoodleRoleAssignationV.where(:userid => @user.id).group(:courseid).map{|c| c.courseid}
		if params[:filter]
			if params[:filter][:show_hidden]
				@courses = DashboardCoursesV.where(:courseid => my_courses)
				@filters[:show_hidden] = true
			else
				@courses = DashboardCoursesV.where(:courseid => my_courses, :visible => 1)
			end
		else
			@courses = DashboardCoursesV.where(:courseid => my_courses, :visible => 1)
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
			@taken_sessions = StudentAttendanceReport.where("courseid = #{@course.moodleid} and created_at = curdate()").group("sessionid").order("sessiondate ASC").map{|s| s.description}
			@course_observations = CourseObservation.where(:course_id => @course.moodleid)
		else
			redirect_to :action => :my_courses
		end
	end

	def show_student
		if check_own_course(params[:courseid])
			@course_grades = StudentGradesReport.where("userid = #{params[:studentid]} and courseid = #{params[:courseid]} and created_at = curdate()").order("sortorder ASC")
			@grade_categories = @course_grades.where("categoryname != '?' and itemname is null")
			@general_attendance = StudentGeneralAttendanceReport.where("userid = #{params[:studentid]} and courseid = #{params[:courseid]} and created_at = curdate()")
			@student_info = UserReport.select("userid, firstname, lastname, concat(firstname, ' ', lastname) as name, institution, department, username").where(:userid => params[:studentid]).first()
			@other_courses = StudentGradesReport.select("distinct(courseid)").where("userid = #{@student_info.userid} and courseid != #{params[:courseid]} and created_at = curdate()")
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
