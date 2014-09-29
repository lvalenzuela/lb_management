class MainController < ApplicationController
    before_filter :check_authentication
    protect_from_forgery
    require 'bcrypt'
    layout "dashboard"

    def index
      
    end

    def extras
        source = "https://invoice.zoho.com/api/v3/items?authtoken="+zoho_auth_token+"&organization_id=39721460"
        resp = Net::HTTP.get_response(URI.parse(source))
        data = resp.body
        @response = JSON.parse data
    end

    def system_manager
        @managers = get_system_managers
        @roles = Role.where("id <> 1")
        @remaining_users = UserV.where("id not in (?)", @managers.map{|m| m.id}).page(params[:page]).per(10)
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
        @areas = areas_for_user(current_user.id)
        @active = params[:opt] ? params[:opt].to_s : @areas.first().id.to_s
        @selected_area = @areas.find(@active.to_i)
        @area_users = get_area_users(@selected_area.id)
        @system_users = @area_users.blank? ? UserV.all() : UserV.where("id not in (?)", @area_users.map{|u| u.id})
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
        if current_user.system_role_id <= 2
            r.destroy
            flash[:notice] = "El usuario ha sido eliminado del Área."
            
        else
            flash[:notice] = "No estas autorizado para realizar esta acción."
        end
        redirect_to :action => "area_manager", :opt => params[:area]
    end

    def teachers_manager
        @teachers = TeacherV.all()
    end

    def teacher_availability
        @teacher = TeacherV.find(params[:id])
        @disponibility = UserDisponibility.where("user_id = #{params[:id]} and (end_date >= curdate() or end_date is null)")
        course_ids = MoodleRoleAssignationV.where(:userid => params[:id]).map{|c| c.courseid}
        sessions = MoodleCourseSessionV.joins("as mcs inner join moodle_course_vs as courses
                                                on mcs.courseid = courses.moodleid").where("
                                                mcs.courseid in (?)",course_ids).select("
                                                                                        mcs.*,
                                                                                        courses.coursename").order("courses.coursename")
        calendar_events = []
        sessions.each do |s|
            calendar_events << {
                "title" => s.coursename,
                "start" => s.session_date,
                "allDay" => false,
                "backgroundColor" => "#0073b7",
                "borderColor" => "#0073b7"
            }
        end
        gon.events = calendar_events
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
        return UserV.joins("as users inner join role_assignations as ra
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
            return Area.where(:id => ctx.map{|c| c.instanceid})
        end
    end

    def check_authentication
        if current_user.nil?
          redirect_to :controller => "users", :action => "index"
        end
    end

    def get_area_context(areaid)
        Context.where(:typeid => 2, :instanceid => areaid).first()
    end

    def get_system_managers
        admins = UserV.joins("as users inner join role_assignations as ra
                            on users.id = ra.userid
                            and ra.contextid = 1
                            and ra.roleid in (1,2)").select("users.id,
                                                            users.firstname,
                                                            users.lastname,
                                                            users.username,
                                                            ra.roleid")
    end

    def zoho_auth_token
        return "c08fd565113c4bbe94df623ecf397be5"
    end
end
