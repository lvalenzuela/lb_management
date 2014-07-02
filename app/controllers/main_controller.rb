class MainController < ApplicationController
    before_filter :check_authentication
    protect_from_forgery
    require 'bcrypt'
    layout "dashboard"
    include MainHelper

    def index
      
    end

    def area_manager
        #Administración de las áreas de Longborun y de los roles de los usuarios en ellas
        @areas = Area.all()
        @users = User.all()
        @roles = Role.all()
    end

    def area_dashboard
        @area = Area.find(params[:id])
        @roles = Role.all()
        c = get_area_context(@area.id)

        @users = User.joins("inner join role_assignations as ra
                            on users.id = ra.userid and 
                            ra.contextid = #{c.id}").select("users.id, 
                                                            users.firstname, 
                                                            users.lastname, 
                                                            users.username,
                                                            users.email,
                                                            ra.roleid,
                                                            ra.id as assignationid")
    end

    def assign_role
        c = get_area_context(params[:area])
        if params[:user]
            params[:user].each do |u|
                r = RoleAssignation.where(:contextid => c.id, :userid => u).first()
                if r.nil? 
                    #Si el usuario no ha sido previamente asignado al área
                    #se le asigna un rol
                    RoleAssignation.create(:contextid => c.id, :userid => u, :roleid => params[:role])
                else 
                    #si el usuario ya tenia un rol en el área, se modifica
                    r.update_attributes(:roleid => params[:role])
                end
            end
            flash[:notice] = "Asignacion llevada a cabo con éxito."
        else
            flash[:notice] = "Debe seleccionar un usuario."
        end
        
        redirect_to :action => "area_manager"
    end

    def modify_assignation
        c = get_area_context(params[:area])
        if params[:assign]
            params[:assign].each do |a|
                assignation = RoleAssignation.find(a)
                assignation.update_attributes(:roleid => params[:role])
            end
            flash[:notice] = "Asignacion llevada a cabo con éxito."
        else
            flash[:notice] = "Debe seleccionar un usuario."
        end
        redirect_to :action => "area_dashboard", :id => params[:area]
    end

    def destroy
        r = RoleAssignation.find(params[:id])
        if session[:system_role] <= 2
            r.destroy
            flash[:notice] = "El usuario ha sido eliminado del Área."
            
        else
            flash[:notice] = "No estas autorizado para realizar esta acción."
        end
        redirect_to :action => "area_dashboard", :id => params[:areaid]
    end

    private
    
    def check_authentication
        if session[:user_id].nil?
          redirect_to :controller => "users", :action => "index"
        end
    end

    def get_area_context(areaid)
        Context.where(:descriptionid => 2, :instanceid => areaid).first()
    end
end
