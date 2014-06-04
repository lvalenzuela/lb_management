class MainController < ApplicationController
  protect_from_forgery
  protect_from_forgery
  require 'bcrypt'
  layout "dashboard"

  def index
    if !session[:user_id].nil?
      redirect_to :action => 'control_panel'
    end
  end

  def login
    user = User.where(:username => params[:username]).first()
    if user.blank?
      flash[:notice] = "Nombre de usuario incorrecto, por favor vuelve a intentarlo"
      redirect_to :action => "index"
    elsif !user.username.end_with?("@longbourn.cl") 
      flash[:notice] = "Usuario no autorizado para ingresar al sistema"
      redirect_to :action => "index" 
    else
      fixed_pass = user.password
      fixed_pass[2] = "a" #se reemplaza de 'y' a 'a' para que se reconozca (blowfish)
      password = BCrypt::Password.new(user.password)
      usertype = ManagementUserPermission.where(:userid => user.id).first().permission_type
      if password == params[:password] && usertype <= 2 #permitir solo administradores
        session[:usertype] = usertype
        session[:user_id] = user.id
        session[:username] = user.username
        redirect_to :action => 'control_panel'
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

  def control_panel
    
  end

  def user_profile
    
  end

  def under_construction

  end

  def show

  end

  private

end
