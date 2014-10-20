class CoursesController < ApplicationController
    before_filter :check_authentication
    protect_from_forgery
    layout "dashboard"

    def index
        case params[:opt]
        when "production"
            c_list = Course.where(:course_status_id => 4).order("start_date ASC")
            @active = "production"
        when "canceled"
            c_list = Course.where(:course_status_id => 3).order("start_date ASC")
            @active = "canceled"
        else
            c_list = Course.where(:course_status_id => [1,2]).order("start_date ASC")
            @active = "staged"
        end
        @courses = c_list.page(params[:page]).per(10)
    end

    def template_selector_options
        @templates = CourseTemplate.where(:course_level_id => params[:courselevel], :deleted => 0)
        respond_to do |format|
            format.js
        end
    end

    def product_selector_options
        @products = CourseModeZohoProductMap.where(:enabled => true, :course_mode_id => params[:coursemode])

        respond_to do |format|
            format.js
        end
    end

    def sessions_per_week_inputs
        @per_week = params[:sessions_pw].to_i
        
        respond_to do |format|
            format.js
        end
    end

    def new
        @products = nil
    	@types = CourseType.all()
    	@course = Course.new()
        @course_levels = CourseLevel.all()
        @modes = CourseMode.where(:enabled => true)
        @templates = nil
    end

    def create
        @course = Course.create(course_params)
    	if @course.valid?
            #Registro de los días de la semana en que hay clases
            register_weekday_sessions(@course)
            #creacion de las sesiones correspondientes al curso
            create_course_sessions(@course)
            redirect_to :action => :assign_teacher, :id => @course.id
    	else
    		if @course.mode
                @products = CourseModeZohoProductMap.where(:enabled => true, :course_mode_id => @course.mode)
            else
                @products = nil
            end
            @modes = CourseMode.where(:enabled => true)
	    	@types = CourseType.all()
            @course_levels = CourseLevel.all()
            @templates = CourseTemplate.where(:deleted => 0)
	    	render :new
    	end
    end

    def edit
        @types = CourseType.all()
        @course = Course.find(params[:id])
        if @course.mode
            @products = CourseModeZohoProductMap.where(:enabled => true, :course_mode_id => @course.mode)
        else
            @products = nil
        end
        @modes = CourseMode.where(:enabled => true)
        @templates = CourseTemplate.where(:course_level_id => @course.course_level_id, :deleted => 0)
        @course_levels = CourseLevel.all()
        @week_sessions = CourseSessionWeekday.where(:course_id => params[:id])
    end

    def update
        @course = Course.find(params[:course][:id])
        @course.update_attributes(course_params)
        if @course.valid?
            #Eliminacion de los datos correspondientes a las sesiones en la semana
            CourseSessionWeekday.where(:course_id => @course.id).destroy_all
            #Registro de los días de la semana en que hay clases
            register_weekday_sessions(@course)
            #eliminacion de las sesiones antiguas del curso
            CourseSession.where(:commerce_course_id => @course.id).destroy_all
            #creacion de las nuevas sesiones correspondientes al curso
            create_course_sessions(@course)
            redirect_to :action => :index
        else
            if @course.mode
                @products = CourseModeZohoProductMap.where(:enabled => true, :course_mode_id => @course.mode)
            else
                @products = nil
            end
            @modes = CourseMode.where(:enabled => true)
            @types = CourseType.all()
            @course_levels = CourseLevel.all()
            @templates = CourseTemplate.where(:deleted => 0)
            @week_sessions = CourseSessionWeekday.where(:course_id => @course.id)
            render :edit    
        end
    end

    def assign_teacher
        @course = Course.find(params[:id])
        @week_session_info = CourseSessionWeekday.where(:course_id => @course.id).order("day_number ASC")
        teacher_list = available_teachers_for_course(@week_session_info, false)
        extra_teachers_list = available_teachers_for_course(@week_session_info, true)

        #listado de profesores disponibles en horario normal
        @teachers = TeacherV.where(:id => teacher_list)
        #listado de profesores disponibles en horario extra
        @teachers_extra = TeacherV.where(:id => extra_teachers_list)

        gon.events = []

        #sesiones del nuevo curso
        c_sessions = CourseSession.where(:commerce_course_id => @course.id)
        c_sessions.each do |cs|
            gon.events << {
                "title" => @course.coursename,
                "start" => cs.startdatetime,
                "allDay" => false,
                "backgroundColor" => "#0073b7",#azul
                "borderColor" => "#0073b7"
            }
        end

        if params[:teacherid] && params[:teacherid].to_i != @course.main_teacher_id
            #sesiones de la simulacion [cursos moodle]
            @simulated = TeacherV.find(params[:teacherid])
            t_sessions = teacher_courses_sessions(params[:teacherid])
            t_sessions.each do |s|
                gon.events << {
                    "title" => MoodleCourseV.find_by_moodleid(s.courseid).coursename,
                    "start" => s.session_date,
                    "allDay" => false,
                    "backgroundColor" => "#f56954",#rojo
                    "borderColor" => "#f56954"
                }
            end
            #sesiones de la simulación[Cursos summit]
            s_sessions = teacher_summit_courses_sessions(params[:teacherid])
            s_sessions.each do |ss|
                gon.events << {
                    "title" => Course.find(ss.commerce_course_id).coursename,
                    "start" => ss.startdatetime,
                    "allDay" => false,
                    "backgroundColor" => "#f39c12",#Amarillo
                    "borderColor" => "#f39c12"
                }
            end
            @moodle_collisions = find_collisions(t_sessions.map{|moodle| moodle.session_date}, c_sessions.map{|new_course| new_course.startdatetime})
            @summit_collisions = find_collisions(s_sessions.map{|summit| summit.startdatetime}, c_sessions.map{|new_course| new_course.startdatetime})
        end
        if @course.main_teacher_id
            #sesiones del profesor que ya tiene el curso asignado
            m_sessions = teacher_courses_sessions(@course.main_teacher_id)
            m_sessions.each do |ms|
                gon.events << {
                    "title" => MoodleCourseV.find_by_moodleid(ms.courseid).coursename,
                    "start" => ms.session_date,
                    "allDay" => false,
                    "backgroundColor" => "#00a65a",#verde
                    "borderColor" => "#00a65a"
                }
            end
        end

        @week_sessions = CourseSessionWeekday.where(:course_id => @course.id)

    end

    def bind_course_teacher
        c = Course.find(params[:courseid])
        c.main_teacher_id = params[:teacherid]
        c.save!
        redirect_to :action => :assign_teacher, :id => params[:courseid], :teacherid => params[:teacherid]
    end

    def show 
        @course = Course.find(params[:id])
        @week_sessions = CourseSessionWeekday.where(:course_id => @course.id)
        if @course.main_teacher_id
            @teacher = TeacherV.find(@course.main_teacher_id)
        else
            @teacher = nil
        end
        student_list = CourseMember.where(:course_id => @course.id)
        @students = WebUser.where(:id => student_list.map{|s| s.web_user_id})
        @course_statuses = CourseStatus.all()
    end

    def course_students
        @course = Course.find(params[:courseid])
        c_students = CourseMember.where(:course_id => @course.id).map{|c| c.web_user_id}
        @enroled_students = WebUser.where(:id => c_students)
        if c_students.blank?
            s = WebUser.all()
        else
            s = WebUser.where("id not in (?)",c_students)
        end
        @students = s

        #identificar si se desea editar
        if params[:edit_user]
            @new_student = WebUser.find(params[:edit_user])
            @editable = true
        else
            @new_student = WebUser.new()
        end
    end

    def create_student
        @new_student = WebUser.create(web_user_params)
        if @new_student.valid?
            if params[:enrol]
                enrol_student(@web_user.id, params[:courseid])
            end
            redirect_to :action => :course_students, :courseid => params[:courseid]
        else
            @course = Course.find(params[:courseid])
            c_students = CourseMember.where(:course_id => @course.id).map{|c| c.web_user_id}
            @enroled_students = WebUser.where(:id => c_students)
            if c_students.blank?
                s = WebUser.all()
            else
                s = WebUser.where("id not in (?)",c_students)
            end
            @students = s
            render :course_students
        end
    end

    def update_student
        @new_student = WebUser.find(params[:web_user][:id])
        @new_student.update_attributes(web_user_params)
        if @new_student.valid?
            if params[:enrol]
                enrol_student(@web_user.id, params[:courseid])
            end
            redirect_to :action => :course_students, :courseid => params[:courseid]
        else
            @course = Course.find(params[:courseid])
            c_students = CourseMember.where(:course_id => @course.id).map{|c| c.web_user_id}
            @enroled_students = WebUser.where(:id => c_students)
            if c_students.blank?
                s = WebUser.all()
            else
                s = WebUser.where("id not in (?)",c_students)
            end
            @students = s
            render :course_students
        end
    end

    def enrolement_management
        course = Course.find(params[:courseid])
        if params[:enrol]
            enrol_student(params[:studentid],params[:courseid])
        elsif params[:unenrol]
            unenrol_student(params[:studentid],params[:courseid])
        end
        #Se identifica la cantidad de estudiantes que tiene el curso actualmente
        course.count_students
        redirect_to :action => :course_students, :courseid => params[:courseid]
    end

    def init_course_dialog
        @course = Course.find(params[:courseid])
        #categoría para la creación de cursos es 2
        @course_init_tasks = RequestTag.where(:category_id => 2)
    end

    def init_course
        course = Course.find(params[:courseid])
        begin
            #archivo de estudiantes
            members_attachment = Tempfile.new(["LISTADO-ALUMNOS_#{course.coursename}",".csv"])
            course_attachment = Tempfile.new(["DATOS_CURSO_#{course.coursename}",".csv"])
            course_sessions_attachment = Tempfile.new(["SESIONES_CURSO_#{course.coursename}",".csv"])

            #rellenar archivos
            members_attachment = course_members_file(members_attachment,course)
            course_attachment = course_data_file(course_attachment,course)
            course_sessions_attachment = course_sessions_file(course_sessions_attachment,course)

            #generar requerimientos
            tasks = RequestTag.where(:category_id => 2)
            tasks.each do |t|
                #nuevo requerimiento
                req = Request.new()
                req.tagid = t.id
                req.userid = current_user.id
                req.subject = t.tagname+" - "+course.coursename
                req.receiverid = t.default_user_id
                req.areaid = t.area_id
                req.priorityid = 3 #prioridad normal
                req.request = t.default_msg ? t.default_msg : " "
                req.save!
                #adjuntar miembros del curso
                attach_members = RequestAttachment.new()
                attach_members.request_id = req.id
                attach_members.attached_file = members_attachment
                attach_members.save!
                #adjuntar datos del curso
                attach_course_data = RequestAttachment.new()
                attach_course_data.request_id = req.id
                attach_course_data.attached_file = course_attachment
                attach_course_data.save!
                #adjuntar sesiones del curso
                attach_course_sessions = RequestAttachment.new()
                attach_course_sessions.request_id = req.id
                attach_course_sessions.attached_file = course_sessions_attachment
                attach_course_sessions.save!
            end
        ensure
            members_attachment.close
            members_attachment.unlink
            course_attachment.close
            course_attachment.unlink
        end
        #se cambia el estado del curso a "en desarrollo"
        course.course_status_id = 4
        course.save!
        redirect_to :action => :index, :opt => "production"
    end

    def change_status
        c = Course.find(params[:id])
        case params[:status]
        when "cancel"
            c.course_status_id = 3
            c.save!
        else
            if c.current_students_qty == 0
                c.course_status_id = 1
                c.save!
            else
                c.course_status_id = 2
                c.count_students
                c.save!
            end
        end
        redirect_to :action => :index, :opt => params[:active]
    end

    def cancel_course
        c = Course.find(params[:id])
        #se cancela el curso
        c.update_attributes(:course_status_id => 3)
        redirect_to :action => :index
    end


    def course_templates
        @templates = CourseTemplate.where(:deleted => 0).page(params[:page]).per(10)
    end

    def new_template
        @course_levels = CourseLevel.all()
    end

    def create_template
        @template = CourseTemplate.create(course_template_params)
        if @template.valid?
            redirect_to :action => :course_templates
        else
            @course_levels = CourseLevel.all()
            render :new_template
        end
    end

    def delete_template
        t = CourseTemplate.find(params[:id])
        t.deleted = 1
        t.save!
        redirect_to :action => :course_templates
    end

    def edit_template
        @template = CourseTemplate.find(params[:id])
        @course_levels = CourseLevel.all()
        @template_sessions = CourseTemplateSession.where(:course_template_id => params[:id])
    end

    def update_template
        @template = CourseTemplate.find(params[:course_template][:id])
        @template.update_attributes(course_template_params)
        if @template.valid?
            redirect_to :action => :course_templates
        else
            @course_levels = CourseLevel.all()
            render :edit_template
        end
    end

    def template_details
        @template = CourseTemplate.find(params[:id])
        @template_sessions = CourseTemplateSession.where(:course_template_id => params[:id])
        @session_types = CourseSessionType.all()
    end

    def update_template_sessions
        template_sessions = CourseTemplateSession.where(:course_template_id => params[:template_id])
        template_sessions.each do |ts|
            ts.session_type_id = params["session_type_id_"+ts.session_number.to_s]
            ts.page = params["page_"+ts.session_number.to_s]
            ts.contents = params["contents_"+ts.session_number.to_s]
            ts.save!
        end
        redirect_to :action => :edit_template, :id => params[:template_id]
    end

    def edit_session_types
        @session_types = CourseSessionType.all()
        if params[:id]
            @editable = CourseSessionType.find(params[:id])
        end
    end

    def create_session_type
        CourseSessionType.create(course_session_type_params)
        redirect_to :action => :edit_session_types
    end

    def update_session_type
        session_type = CourseSessionType.find(params[:course_session_type][:id])
        session_type.update_attributes(course_session_type_params)
        redirect_to :action => :edit_session_types
    end



    private

    def course_sessions_file(file,course)
        sessions = CourseSession.where(:commerce_course_id => course.id)

        headers = ["Numero de Sesión", "Fecha", "Hora de Inicio"]
        CSV.open(file.path, "w") do |csv|
            csv << headers
            sessions.each do |s|
                csv << [s.session_number, l(s.startdatetime, :format => "%d - %m - %Y"), l(s.startdatetime, :format => "%H:%M")]
            end
        end
        return file
    end

    def course_members_file(file,course)
        member_list = CourseMember.where(:course_id => course.id).map{|cm| cm.web_user_id}
        members = WebUser.where(:id => member_list)

        #Creacion del archivo adjunto conteniendo al listado de alumnos
        student_list_headers = ["Nombre", "Apellido", "Email", "Género"]
        CSV.open(file.path,"w") do |csv|
            csv << student_list_headers
            members.each do |m|
                csv << [m.firstname, m.lastname, m.email, m.gender.include?("male") ? "Masculino" : "Femenino"]
            end
        end
        return file
    end

    def course_data_file(file,course)
        CSV.open(file.path,"w") do |csv|
            csv << ["Curso", course.coursename]
            csv << ["Descripcion", course.description]
            csv << ["Nivel", CourseLevel.find(course.course_level_id).course_level]
            csv << ["Cantidad de Alumnos", course.current_students_qty]
            csv << ["Profesor a Cargo", TeacherV.find(course.main_teacher_id).name]
            csv << ["Libro del Curso", CourseTemplate.find(course.course_template_id).name]
            csv << ["Fecha de Inicio", l(course.start_date, :format => "%d - %m - %Y")]
        end
        return file
    end

    def find_collisions(fixed_sessions, new_course_sessions)
        collisions = []
        fixed_sessions.each do |fs|
            new_course_sessions.each do |ncs|
                if fs.strftime("%d-%m-%Y") == ncs.strftime("%d-%m-%Y")
                    #las fechas coinciden
                    if (fs.hour - ncs.hour).abs < 2
                        #las horas coinciden
                        collisions << fs
                    end
                end
            end
        end
        return collisions
    end

    def available_teachers_for_course(week_session_info, extra)
        desired_days = week_session_info.map{|ws| ws.day_number} #array de dias de clases
        #identificar a los profesores disponibles en las fechas correspondientes
        candidate_teachers = TeacherV.all().map{|t| t.id}
        teachers_availability = UserDisponibility.all()
        if extra
            #revisar horarios extras
            desired_days.each do |day|
                teachers_availability = teachers_availability.where(:user_id => candidate_teachers)
                available_teachers = teachers_availability.where("day_number = #{day} and time('#{week_session_info.where(:day_number => day).first.session_start_hour}') between time(extra_start_time) and time(extra_end_time)").group("user_id")
                candidate_teachers = available_teachers.map{|at| at.user_id} #listado de profesores que cumplieron las condiciones
            end
            #cambio de nombre de la variable
            #para que el concepto sea mas
            #comprensible
            available_teachers = candidate_teachers
        else
            #revisar horario normal
            desired_days.each do |day|
                teachers_availability = teachers_availability.where(:user_id => candidate_teachers)
                available_teachers = teachers_availability.where("day_number = #{day} and time('#{week_session_info.where(:day_number => day).first.session_start_hour}') between time(start_time) and time(end_time)").group("user_id")
                candidate_teachers = available_teachers.map{|at| at.user_id} #listado de profesores que cumplieron las condiciones
            end
            #cambio de nombre de la variable
            #para que el concepto sea mas
            #comprensible
            available_teachers = candidate_teachers
        end
        return available_teachers
    end

    def web_user_params
        params.require(:web_user).permit(:firstname, :lastname, :email, :phone, :gender)
    end

    def enrol_student(student_id, course_id)
        CourseMember.create(:course_id => course_id, :web_user_id => student_id)
    end

    def unenrol_student(student_id, course_id)
        CourseMember.where(:course_id => course_id, :web_user_id => student_id).destroy_all
    end

    def teacher_courses_sessions(teacherid)
        course_list = MoodleRoleAssignationV.where(:userid => teacherid, :roleid => [9,4]).map{|c| c.courseid}
        return MoodleCourseSessionV.where(:courseid => course_list)
    end

    def teacher_summit_courses_sessions(teacherid)
        #cursos que no esten asociados con un curso en moodle
        course_list = Course.where(:main_teacher_id => teacherid, :moodleid => nil, :course_status_id => [1,2,4]).map{|c| c.id}
        return CourseSession.where(:commerce_course_id => course_list)
    end

    def course_session_type_params
        params.require(:course_session_type).permit(:type_name, :description)
    end

    def course_template_params
        params.require(:course_template).permit(:course_level_id,:name,:total_sessions)
    end

    def register_weekday_sessions(course)
        for s in 1..course.sessions_per_week
            weekday_session = CourseSessionWeekday.new()
            weekday_session.course_id = course.id
            weekday_session.order = params[:wday_order]["#{s}"]
            weekday_session.day_number = params[:week_day]["#{s}"]
            weekday_session.session_start_hour = params[:session_hour]["#{s}"]
            weekday_session.save!
        end
    end

    def create_course_sessions(course)
        total_sessions = CourseTemplate.find(course.course_template_id).total_sessions.to_i
        week_sessions_info = CourseSessionWeekday.where(:course_id => course.id)
        desired_days = week_sessions_info.map{|wd| wd.day_number}
        for session_number in 1..total_sessions
            new_session = CourseSession.new()
            new_session.commerce_course_id = course.id
            new_session.session_number = session_number
            if session_number == 1
                #solo para la primera sesion
                current_session_date = session_datetime(desired_days, course.start_date, week_sessions_info)
            else
                current_session_date = session_datetime(desired_days, current_session_date + 1.days, week_sessions_info)
            end
            new_session.startdatetime = current_session_date
            new_session.save!
        end
        #se considera la ultima sesion del curso como la fecha de término del mismo
        course.end_date = current_session_date
        course.save!
    end

    def session_datetime(desired_days, session_date, week_sessions_info)
        holydays = CalendarHolyday.all().map{|h| DateTime.parse(l(h.date, :format => "%d-%m-%Y"))} #array de días en los que no habrá clases
        session_date = DateTime.parse(l(session_date, :format => "%d-%m-%Y"))
        #Se verifica que las sesiones se asignen a los días de la semana que corresponden
        #y a días que no sean considerados festivos
        session_date += 1.days while ( !desired_days.include?(session_date.wday) || holydays.include?(session_date))
        raw_hour = week_sessions_info.select{|ws| ws.day_number == session_date.wday}.first().session_start_hour
        session_hour = raw_hour.split(":")
        #se modifica la hora segun la que se haya registrado
        session_date = session_date.change(:hour => session_hour[0].to_i, :min => session_hour[1].to_i)
        return session_date
    end

    def get_teachers_list
        c = get_area_context(2)
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

    def get_area_context(areaid)
        #Area docente ID = 2
        return Context.where(:typeid => 2, :instanceid => areaid).first()
    end

    def course_params
    	params.require(:course).permit(:coursename, :course_template_id, :description, :course_level_id, :sessions_per_week, :mode, :teacher_user_id, :students_qty, :zoho_product_id, :start_date, :location, :course_type_id)
    end

    def check_authentication
        if current_user.nil?
          redirect_to :controller => "users", :action => "index"
        end
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

    def zoho_product_list
        data = get_zoho_data("Longbourn","invoice")
    	url = "https://invoice.zoho.com/api/v3/items?authtoken="+data.authtoken+"&organization_id="+data.organization_id
    	resp = Net::HTTP.get_response(URI.parse(url))
    	return JSON.parse resp.body
    end
end
