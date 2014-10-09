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
		my_courses = MoodleRoleAssignationV.where(:userid => @user.id).map{|c| c.courseid}
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
		@courses = @courses.order("courseid ASC")
	end

	private

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
