class UsersController < ApplicationController
	protect_from_forgery
	require 'bcrypt'
	layout "dashboard"	
	
	def index
	    #Si el usuario ya esta logeado, se redirige al panel de control
	    if !session[:user_id].nil?
	      redirect_to :controller => "main", :action => 'index'
	    end
	end

	def login
	    user = User.where(:username => params[:username]).first()
	    if user.blank? || user.nil?
	      flash[:notice] = "Nombre de usuario incorrecto, por favor vuelve a intentarlo"
	      redirect_to :action => "index"
	      #Permitir el ingreso sólo de usuarios de Longbourn.
	    elsif !user.username.end_with?("@longbourn.cl")
	      flash[:notice] = "Usuario no autorizado para ingresar al sistema"
	      redirect_to :action => "index" 
	    else
			fixed_pass = user.password
			fixed_pass[2] = "a" #se reemplaza de 'y' a 'a' para que se reconozca (blowfish)
			password = BCrypt::Password.new(user.password)
			if password == params[:password] 
				session[:system_role] = role_in_system(user.id)
				session[:user_id] = user.id
				redirect_to root_path
			else
				flash[:notice] = "Contraseña incorrecta, por favor vuelve a intentarlo."
				redirect_to :action => "index"
			end
	    end
	end

	def logout
	    session.clear
	    redirect_to :action => "index"
	end

	def show

	end

	private
	
	def role_in_system(userid)
		u = RoleAssignation.where(:userid => userid, :contextid => 1).first()
		
		if u.nil?
			return 1000 # Mientras mayor es el rol, menores los privilegios
		else
			return u.roleid
		end
	end
end
