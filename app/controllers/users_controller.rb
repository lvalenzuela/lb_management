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
	      if user.permissionid <= 2 #permitir solo administradores
		      if password == params[:password] 
		        session[:usertype] = user.permissionid
		        session[:user_id] = user.id
		        session[:user_area] = user_area(user.id)
		        redirect_to root_path
		      else
		        flash[:notice] = "Contraseña incorrecta, por favor vuelve a intentarlo."
		        redirect_to :action => "index"
		    end
		  else
		  	flash[:notice] = "Usuario no autorizado."
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

	def user_area(id)
		user_areaname = User.find(id).department
		area = RequestArea.where(:areaname => user_areaname).first()
		return area.id
	end
end
