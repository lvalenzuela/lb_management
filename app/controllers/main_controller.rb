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
        @areas = areas_for_user(session[:user_id])
        @active = params[:opt] ? params[:opt].to_s : @areas.first().id.to_s
        @selected_area = @areas.find(@active.to_i)
        @area_users = get_area_users(@selected_area.id)
        @system_users = User.where("id not in (?)", @area_users.map{|u| u.id})
        @roles = Role.all()
    end


    def assign_to_area
        assign_area_member(params[:area],params[:user])
        redirect_to :action => "area_manager", :opt => params[:area]
    end

    def modify_assignation
        c = get_area_context(params[:area])
        if params[:assign]
            params[:assign].each do |a|
                assignation = RoleAssignation.find(a)
                assignation.update_attributes(:roleid => params[:role])
            end
        end
        redirect_to :action => "area_manager", :opt => params[:area]
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

    def assign_area_member(areaid,userid)
        c = get_area_context(areaid)
        r = RoleAssignation.where(:contextid => c.id, :userid => userid).first()
        if r.nil? 
            #Si el usuario no ha sido previamente asignado al área
            #se le asigna el rol de miembro
            RoleAssignation.create(:contextid => c.id, :userid => userid, :roleid => 3)
        end
        #si el usuario ya tenia un rol en el área no se hace nada
    end

    def get_area_users(areaid)
        c = get_area_context(areaid)
        return User.joins("inner join role_assignations as ra
                                on users.id = ra.userid and 
                                ra.contextid = #{c.id}").select("users.id, 
                                                                users.firstname, 
                                                                users.lastname, 
                                                                users.username,
                                                                users.email,
                                                                ra.roleid,
                                                                ra.id as assignationid")
    end

    def areas_for_user(userid)
        check_if_system_manager = get_system_managers.select{|user| user.id == userid}
        if !check_if_system_manager.empty? || !check_if_system_manager.blank?
            return Area.all()
        else
            ctx = Context.joins("inner join areas
                                    on areas.id = contexts.instanceid
                                    and contexts.typeid = 2
                                inner join role_assignations as ra
                                    on contexts.id = ra.contextid
                                    and ra.userid = #{userid}
                                    and ra.roleid in (1,2)")
            area_list = []
            ctx.each do |c|
                area_list << c.instanceid
            end

            return Area.where(:id => area_list)
        end
    end
    
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
