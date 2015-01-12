class MainController < ApplicationController
    before_filter :check_authentication
    protect_from_forgery
    require 'bcrypt'
    require "csv"
    layout "dashboard"

    def index
      
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

    def change_area_request_status
        case params[:status]
        when "enable"
            area = RequestEnabledArea.find_by_area_id(params[:area])
            if area.blank?
                new_area = RequestEnabledArea.new()
                new_area.area_id = params[:area]
                new_area.save! 
            else
                #el area ya esta habilitada
            end
        else #disable
            #se elimina el registro
            RequestEnabledArea.find_by_area_id(params[:area]).destroy
        end
        redirect_to :action => :area_manager, :opt => params[:area]
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

    def teacher_grades_config
        @teacher_levels = TeacherLevel.all()
    end

    def create_teacher_level
        @teacher_level = TeacherLevel.create(teacher_level_params)
        if @teacher_level.valid?
            redirect_to :action => :teacher_grades_config
        else
            @teacher_levels = TeacherLevel.all()
            render :teacher_grades_config
        end
    end

    def edit_teacher_level
        @teacher_levels = TeacherLevel.all()
        @teacher_level = TeacherLevel.find(params[:id])
        render :teacher_grades_config
    end

    def update_teacher_level
        @teacher_level = TeacherLevel.find(params[:user_teacher_level][:id])
        @teacher_level.update_attributes(teacher_level_params)
        if @teacher_level.valid?
            redirect_to :action => :teacher_grades_config
        else
            @teacher_levels = TeacherLevel.all()
            render :teacher_grades_config
        end
    end

    def delete_teacher_level
        TeacherLevel.find(params[:id]).destroy
        redirect_to :action => :teacher_grades_config
    end

    def teachers_manager
        @teachers = TeacherV.all()
    end

    def set_teacher_level
        if params[:teacher_level]
            teacher = User.find(params[:id])
            teacher.teacher_level_id = params[:teacher_level]
            teacher.save!
        end
        redirect_to :action => :teacher_overview, :id => params[:id]
    end

    def teacher_evaluation
        @teacher = TeacherV.find(params[:teacherid])
    end

    def teacher_overview
        @teacher = TeacherV.find(params[:id])
        @teacher_levels = TeacherLevel.all()
        @disponibility = UserDisponibility.where(:user_id => params[:id])
        course_ids = MoodleRoleAssignationV.where(:userid => params[:id], :roleid => [4,9]).map{|c| c.courseid}
        @courses = MoodleCourseV.where(:moodleid => course_ids, :visible => 1)
        sessions = MoodleCourseSessionV.joins("as mcs inner join moodle_course_vs as courses
                                                on mcs.courseid = courses.moodleid").where("
                                                mcs.courseid in (?)",course_ids).select("
                                                                                        mcs.*,
                                                                                        courses.coursename").order("courses.coursename")
        calendar_events = []
        sessions.each do |s|
            #sesiones de los cursos asignados en moodle
            calendar_events << {
                "title" => s.coursename,
                "start" => s.session_date,
                "allDay" => false,
                "backgroundColor" => "#0073b7",
                "borderColor" => "#0073b7"
            }
        end
        @commerce_courses = Course.where(:main_teacher_id => @teacher.id, :moodleid => nil, :course_status_id => [1,2,4])
        comm_sessions = CourseSession.where(:commerce_course_id => @commerce_courses.map{|c| c.id})
        comm_sessions.each do |cs|
            calendar_events << {
                #sesiones de cursos del sistema que no se han registrado aun en moodle
                "title" => Course.find(cs.commerce_course_id).coursename,
                "start" => cs.startdatetime,
                "allDay" => false,
                "backgroundColor" => "#f39c12",
                "borderColor" => "#f39c12"
            }
        end
        gon.events = calendar_events
    end

    def set_user_disponibility
        #se borran todas las disponibilidades previas para el usuario
        UserDisponibility.where(:user_id => params[:userid]).destroy_all
        for day in 1..6
            new_disp = UserDisponibility.new()
            new_disp.user_id = params[:userid]
            new_disp.day_number = day
            save_register = false #flag para guardar el registro

            if params[:enabled_day] && params[:enabled_day]["#{day}"]
                #Solo aquellos dias seleccionados son registrados
                new_disp.start_time = params[:start_time]["#{day}"]
                new_disp.end_time = params[:end_time]["#{day}"]
                save_register = true
            end
            if params[:extra_enabled] && params[:extra_enabled]["#{day}"]
                #horas extras 
                new_disp.extra_start_time = params[:extra_start_time]["#{day}"]
                new_disp.extra_end_time = params[:extra_end_time]["#{day}"]
                save_register = true
            end
            
            if save_register
                #si se guardo algun horario para el dia seleccionado
                new_disp.save!
            end
        end
        redirect_to :action => :teacher_overview, :id => params[:userid]
    end

    def course_modes
        if params[:show_disabled]
            @modes = CourseMode.all()
        else
            @modes = CourseMode.where(:enabled => true)
        end

        if params[:course_mode_id]
            @course_mode = CourseMode.find(params[:course_mode_id])
        end
    end

    def disable_course_mode
        cm = CourseMode.find(params[:course_mode_id])
        cm.enabled = false
        cm.save!
        redirect_to :action => :course_modes
    end

    def create_course_mode
        CourseMode.create(course_mode_params)
        redirect_to :action => :course_modes
    end

    def update_course_mode
        cm = CourseMode.find(params[:course_mode][:id])
        cm.update_attributes(course_mode_params)
        redirect_to :action => :course_modes
    end

    def update_zoho_products
        #agrega productos que no estan y actualiza los productos existentes
        raw_products = get_zoho_product_list
        if raw_products["code"] == 0
            zoho_products = raw_products["items"].select{|i| i["status"] == "active"}
        end

        zoho_products.each do |zp|
            product = CourseModeZohoProductMap.find_by_zoho_product_id(zp["item_id"])
            if product.blank?
                #si el producto no existe, se crea
                CourseModeZohoProductMap.create(:product_name => zp["name"], :zoho_product_id => zp["item_id"], :price => zp["rate"], :enabled => true)
            else
                #si el producto existe, se actualiza
                product.product_name = zp["name"]
                product.price = zp["rate"]
                product.save!
            end
        end
        redirect_to :action => :zoho_product_list
    end

    def zoho_product_list
        raw_products = get_zoho_product_list
        if raw_products["code"] == 0
            zoho_products = raw_products["items"].select{|i| i["status"] == "active"}
        end
        zoho_products.each do |zp|
            product = CourseModeZohoProductMap.find_by_zoho_product_id(zp["item_id"])
            if product.blank?
                #si el producto no existe, se crea
                CourseModeZohoProductMap.create(:product_name => zp["name"], :zoho_product_id => zp["item_id"], :price => zp["rate"], :enabled => true)
            end
        end

        if params[:show_disabled]
            @system_products = CourseModeZohoProductMap.all()
        else
            @system_products = CourseModeZohoProductMap.where(:enabled => true)
        end
        @course_modes = CourseMode.where(:enabled => true)
    end

    def save_products
        params[:product].each do |p|
            m = p.split(",")
            #m[0] = mode_id
            #m[1] = zoho_product_id
            product = CourseModeZohoProductMap.find_by_zoho_product_id(m[1])
            if !product.blank?
                product.course_mode_id = m[0].to_i
                product.save!
            end
        end
        redirect_to :action => :zoho_product_list
    end

    def calendar_management
        holydays = CalendarHolyday.all()
        if holydays.blank?
            @last_date = nil
            @total_dates = 0
        else
            @last_date = holydays.order("date DESC").first().date
            @total_dates = holydays.count
        end
        gon.events = []
        holydays.each do |h|
            gon.events << {
                "title" => "Dia Festivo",
                "start" => h.date,
                "allDay" => true,
                "backgroundColor" => "#f56954",#rojo
                "borderColor" => "#f56954"
            }
        end
    end


    def calendar_file_example
        send_file Rails.root.join("app","assets","file_examples","holyday_input.csv")
    end

    def upload_holydays
        #se borran las fechas anteriores
        CalendarHolyday.all().destroy_all
        #se crean fechas nuevas
        file_contents = params[:holyday_calendar].read
        csv_calendar = CSV.parse(file_contents, :headers => true)
        csv_calendar.each do |row|
            found_date = CalendarHolyday.where("date = '#{row["date"]}'")
            if found_date.blank?
                CalendarHolyday.create(:date => row["date"])
            end
        end
        redirect_to :action => :calendar_management
    end

    def sence_attendance

    end

    def upload_sence_attendance
        #guardar asistencias entregadas por el archivo
         begin
            if params[:sence_file]
                file_contents = params[:sence_file].read
                csv_attendance = CSV.parse(file_contents, :headers => true, :col_sep => ";", :quote_char => "'")
                #longitud del archivo
                new_entry_count = 0
                csv_attendance.each do |row|
                    check = SenceAttendance.where(:codigo_sence => row[1], :sence_idnumber => row[0], :user_rut => row[17], :session_date => Date.parse(row[20]).strftime("%Y-%m-%d"))
                    if !row[17].nil? && row[17] != "" && check.blank?
                        att = SenceAttendance.new()
                        att.codigo_sence = row[1] #codigo sence
                        att.sence_idnumber = row[0] #codigo accion
                        att.institution = row[11].gsub(/["]/, "") #nombre empresa
                        att.user_name = row[18].gsub(/["]/, "") #nombre participante
                        att.user_rut = row[17].gsub(/["]/, "") #rut participante
                        att.course_total_hours = row[12]
                        att.session_date = row[20]
                        att.session_start_time = row[22]
                        att.session_end_time = row[23]
                        att.block_time = row[24]
                        att.user_attendance_time = row[31]
                        att.save!
                        new_entry_count+=1
                    end
                    #linea leida
                end
                @finished = 1
                @new_entries = new_entry_count
            else
                @finished = 2
            end
        rescue => ex
            #puts error.inspect
            @exception_message = ex.message
            @finished = 2
        end
        respond_to do |format|
            format.js
        end
    end

    def course_creation_config
        #Categorías de Requerimientos
        #1.- Requerimientos por defecto del area
        #2.- Requerimientos para creación de cursos
        @request_tags = RequestTag.where(:category_id => 2)

    end

    def new_course_creation_tag
        @request_tag = RequestTag.new()
        @areas = Area.all()
    end

    def create_course_creation_tag
        @request_tag = RequestTag.create(request_tag_params)
        if @request_tag.valid?
            @request_tag.category_id = 2
            @request_tag.save!
            redirect_to :action => :course_creation_tag_preview, :tagid => @request_tag.id
        else
            @areas = Area.all()
            render :new_course_creation_tag
        end
    end

    def course_creation_tag_preview
        @request_tag = RequestTag.find(params[:tagid])
    end

    def edit_course_creation_tag
        @request_tag = RequestTag.find(params[:tagid])
        @areas = Area.all()
    end

    def update_course_creation_tag
        @request_tag = RequestTag.find(params[:request_tag][:id])
        @request_tag.update_attributes(request_tag_params)
        if @request_tag.valid?
            redirect_to :action => :course_creation_tag_preview, :tagid => @request_tag.id
        else
            @areas = Area.all()
            render :edit_course_creation_tag
        end
    end

    def delete_course_creation_tag
        r = RequestTag.find(params[:tagid])
        r.destroy
        redirect_to :action => :course_creation_config
    end

    def classrooms_list
        @classrooms = Classroom.all()
        @classroom = Classroom.new()
    end

    def create_classroom
        @classroom = Classroom.create(classroom_params)
        if @classroom.valid?
            redirect_to :action => :classrooms_list
        else
            render :classrooms_list
        end
    end

    def edit_classroom
        @classroom = Classroom.find(params[:id])
    end

    def update_classroom
        c = Classroom.find(params[:classroom][:id])
        c.update_attributes(classroom_params)
        redirect_to :action => :classrooms_list
    end

    def delete_classroom
        Classroom.find(params[:id]).delete
        redirect_to :action => :classrooms_list
    end

    def classroom_availability
        @availability = ClassroomAvailability.where(:enabled => true)
    end

    def availability_file_example
        send_file Rails.root.join("app","assets","file_examples","tuplas.csv")
    end

    def upload_classroom_availability
        #Se desabilitan las disponibilidades de salas definidas previamente
        #Se desabilitan tambien los slots, dado que cambiaran las disponibilidades de salas 
        disable_classroom_availabilities
        disable_classroom_matchings
        count = 1
        #creacion de nuevos registros
        file_contents = params[:classroom_availability].read
        csv_availability = CSV.parse(file_contents, :headers => true)
        csv_availability.each do |row|
            if row["SALA_ID"] || row["DIA"] || row["HORA"] || row["DURACION"] || row["PRIME"]
                new_entry = ClassroomAvailability.new()
                new_entry.sort_order = count
                new_entry.classroom_id = row["SALA_ID"]
                new_entry.weekday = row["DIA"]
                new_entry.start_hour = row["HORA"]
                new_entry.duration = row["DURACION"]
                new_entry.prime = row["PRIME"]
                new_entry.save!
                count+=1
            end
        end
        redirect_to :action => :classroom_availability
    end

    def classroom_matching
        @matchings = ClassroomMatching.where(:enabled => true)
    end

    def upload_classroom_matching
        #se desabilitan los registros de tabla de "slots", dado que será sobre escrita
        disable_classroom_matchings
        #nuevos registros
        file_contents = params[:matchings].read
        csv_matchings = CSV.parse(file_contents, :headers => true)
        csv_matchings.each do |row|
            #lectura temporal del archivo
            tp1 = ClassroomAvailability.where(:enabled => true, :sort_order => row["TUPLA1"].to_i).first()
            tp2 = ClassroomAvailability.where(:enabled => true, :sort_order => row["TUPLA2"].to_i).first()
            label = week_day(tp1.weekday)+" - "+l(tp1.start_hour, :format => "%H:%M")+" - Sala: #{Classroom.find(tp1.classroom_id).name} || "
            label = label + week_day(tp2.weekday)+" - "+l(tp2.start_hour, :format => "%H:%M")+" - Sala: #{Classroom.find(tp2.classroom_id).name}"
            if tp1 && tp2
                new_entry = ClassroomMatching.new()
                new_entry.matching_array = tp1.id.to_s+","+tp2.id.to_s
                new_entry.matching_label = label
                new_entry.save!
            end
        end
        redirect_to :action => :classroom_matching
    end

    def classroom_matching_example
        send_file Rails.root.join("app","assets","file_examples","classroom_match.csv")
    end



    private

    def teacher_level_params
        params.require(:user_teacher_level).permit(:level_label, :description)
    end

    def week_day(day_number)
        case day_number
        when 1
            return "Lunes"
        when 2
            return "Martes"
        when 3
            return "Miércoles"
        when 4
            return "Jueves"
        when 5
            return "Viernes"
        when 6
            return "Sábado"
        else
            return "Domingo"
        end
    end

    def disable_classroom_availabilities
        ClassroomAvailability.all().update_all(:enabled => false)
    end

    def disable_classroom_matchings
        ClassroomMatching.all().update_all(:enabled => false)
    end

    def classroom_params
        params.require(:classroom).permit(:name, :location, :capacity)
    end

    def request_tag_params
        params.require(:request_tag).permit(:tagname, :area_id, :default_msg)
    end

    def course_mode_params
        params.require(:course_mode).permit(:mode_name, :description, :enabled)
    end

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

    def get_zoho_data(organization,service)
        return ZohoOrganizationData.where(:organization_name => organization, :service => service).first()
    end

    def zoho_get_element(data_type,data_id)
        data = get_zoho_data("Longbourn","invoice")
        url = "https://invoice.zoho.com/api/v3/"+data_type+"/"+data_id+"?authtoken="+data.authtoken+"&organization_id="+data.organization_id
        resp = Net::HTTP.get_response(URI.parse(url))
        return JSON.parse resp.body
    end

    def get_zoho_product_list
        data = get_zoho_data("Longbourn","invoice")
        url = "https://invoice.zoho.com/api/v3/items?authtoken="+data.authtoken+"&organization_id="+data.organization_id
        resp = Net::HTTP.get_response(URI.parse(url))
        return JSON.parse resp.body
    end
end
