class MainController < ApplicationController
    before_filter :check_authentication
    protect_from_forgery
    require 'bcrypt'
    layout "dashboard"
    include MainHelper

    def index
      
    end

    def system_manager
        @managers = get_system_managers
        m_list = []
        @managers.each do |m|
            m_list << m.id
        end
        @roles = Role.where("id <> 1")
        @remaining_users = User.where("id not in (?)", m_list)
    end

    def assign_system_manager
        if params[:user]
            params[:user].each do |u|
                m = RoleAssignation.where(:contextid => 1, :userid => u)
                m.destroy_all
                RoleAssignation.create(:contextid => 1, :userid => u, :roleid => params[:role])
            end
        end
        redirect_to :action => "system_manager"
    end

    def unassign_system_manager
        RoleAssignation.where(:contextid => 1, :userid => params[:userid]).destroy_all
        redirect_to :action => "system_manager"
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

    def manage_products
        @active = "default"
        case params[:ctrl]
        when "deleted"
            #listado de precios eliminados
            @active = "deleted"
            @products = ProductPrice.where("valid_until >= curdate() and deleted = 1")
        when "outdated"
            #precios fuera de fecha
            @active = "outdated"
            @products = ProductPrice.where("valid_until <= curdate() and deleted = 0")
        when "all"
            #Todos los precios
            @active = "all"
            @products = ProductPrice.all()
        else
            #Ni fuera de fecha ni eliminados
            @products = ProductPrice.where("valid_until >= curdate() and deleted = 0")
        end
    end

    def create_product
        ProductPrice.create(product_price_params)
        redirect_to :action => "manage_products"
    end

    def new_product
        @active = "new"
    end

    def edit_product
        @product = ProductPrice.find(params[:id])
    end

    def update_product
        p = ProductPrice.find(params[:product_price][:id])
        p.update_attributes(product_price_params)
        redirect_to :action => "manage_products"
    end

    def enable_product
        p = ProductPrice.find(params[:id])
        p.update_attributes(:deleted => false)
        redirect_to :action => "manage_products"
    end

    def delete_product
        p = ProductPrice.find(params[:id])
        p.update_attributes(:deleted => true)
        redirect_to :action => "manage_products"
    end

    private
    
    def product_price_params
        params.require(:product_price).permit(:modality, :students_qty, :hours_amt, :price, :valid_until, :deleted)
    end

    def check_authentication
        if session[:user_id].nil?
          redirect_to :controller => "users", :action => "index"
        end
    end

    def get_area_context(areaid)
        Context.where(:typeid => 2, :instanceid => areaid).first()
    end

    def get_system_managers
        admins = User.joins("inner join role_assignations as ra
                            on users.id = ra.userid
                            and ra.contextid = 1
                            and ra.roleid in (1,2)").select("users.id,
                                                            users.firstname,
                                                            users.lastname,
                                                            users.username,
                                                            ra.roleid")
    end
end
