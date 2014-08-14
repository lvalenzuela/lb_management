class UsersController < ApplicationController
	protect_from_forgery
	require 'bcrypt'
	layout "dashboard"	
	
	def index
	    #Si el usuario ya esta logeado, se redirige al panel de control
	    if !current_user.nil?
	      redirect_to :controller => "main", :action => 'index'
	    end
	end

	def login
	    user = User.where(:username => params[:username]).first()
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
					cookies.permanent[:auth_token] = user.auth_token
				else
					cookies[:auth_token] = user.auth_token
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
		user = current_user
		user.avatar = params[:avatar]
		user.save!
		redirect_to :action => :user_profile
	end

	private

	def get_user_area_roles(user_id)
		#Se identifican todas las areas del sistema
		contexts = Context.where(:typeid => 2)
		roles = RoleAssignation.where(:userid => user_id, :contextid => contexts.map{|c| c.id})
		return roles
	end
end
