class CoursesController < ApplicationController
    before_filter :check_authentication
    protect_from_forgery
    layout "dashboard"
    require "csv"

    def index
        case params[:opt]
        when "desarrollo"
            c_list = Course.where(:course_status_id => 3).order("start_date ASC")
        when "cancel"
            c_list = Course.where(:course_status_id => 5).order("start_date ASC")
        when "hidden"
            c_list = Course.where(:course_status_id => 1).order("start_date ASC")
        when "finished"
            c_list = Course.where(:course_status_id => 4).order("start_date ASC")
        else
            #active
            c_list = Course.where(:course_status_id => 2).order("start_date ASC")
        end
        @active = params[:opt] ? params[:opt] : "active"
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

    def import_courses
        @types = CourseType.all()
        @modes = CourseMode.where(:enabled => true)
        @course_levels = CourseLevel.all()
        @templates = nil
    end

    def bulk_course_creation
        if params[:course_level_id] && params[:course][:course_template_id] && params[:course][:zoho_product_id] && params[:mode] && params[:courses_file]
            file_contents = params[:courses_file].read
            csv_courses = CSV.parse(file_contents, :headers => true)
            csv_courses.each do |row|
                course = Course.new()
                course.coursename = row["NOMBRE_CURSO"]
                course.description = row["DESCRIPCION"]
                course.course_type_id = row["TIPO_CURSO_ID"]
                course.course_level_id = params[:course_level_id]
                course.students_qty = row["MAX_ALUMNOS"]
                course.mode = params[:mode]
                course.zoho_product_id = params[:course][:zoho_product_id]
                course.course_template_id = params[:course][:course_template_id]
                course.start_date = row["FECHA_INICIO"]
                course.location_id = row["UBICACION_ID"]
                course.classroom_matching_id = row["MATCHING_ID"]
                course.save!
                #sesiones en calendario
                create_course_sessions(course)
            end
        else
            flash[:notice] = "Por favor, indique todos los parametros."
            redirect_to :action => :import_courses
        end
        flash[:notice] = "Importación realizada satisfactoriamente."
        redirect_to :action => :import_courses
    end

    def new
        @products = nil
        @locations = Location.all()
    	@types = CourseType.all()
    	@course = Course.new()
        @course_levels = CourseLevel.all()
        @modes = CourseMode.where(:enabled => true)
        @templates = nil
    end

    def create
        @course = Course.create(course_params)
    	if @course.valid?
            redirect_to :action => :session_data, :id => @course.id
    	else
    		if @course.mode
                @products = CourseModeZohoProductMap.where(:enabled => true, :course_mode_id => @course.mode)
            else
                @products = nil
            end
            @locations = Location.all()
            @modes = CourseMode.where(:enabled => true)
	    	@types = CourseType.all()
            @course_levels = CourseLevel.all()
            @templates = CourseTemplate.where(:deleted => 0)
	    	render :new
    	end
    end

    def session_data_date_warning
        #colisiones_potenciales
        if !params[:selected_match].blank?
            @p_colitions = Course.where("classroom_matching_id = #{params[:selected_match]} and id != #{params[:courseid]} and end_date >= curtime()")
        end

        if !params[:selected_date].blank?
            #alternativas de horarios
            c_matching = ClassroomMatching.find(params[:selected_match])
            week_session_info = ClassroomAvailability.where(:id => c_matching.matching_array.split(","))
            total_sessions = CourseTemplate.find(Course.find(params[:courseid]).course_template_id).total_sessions
            @end_date = course_end_date(week_session_info, params[:selected_date], total_sessions)
        end

        if !params[:selected_match].blank? && !params[:selected_date].blank?
            @p_colitions = @p_colitions.where("end_date between '#{params[:selected_date]}' and '#{l(@end_date, :format => '%Y-%m-%d')}' or start_date between '#{params[:selected_date]}' and '#{l(@end_date, :format => '%Y-%m-%d')}'")
        end
        
        respond_to do |format|
            format.js
        end
    end

    def session_data
        @course = Course.find(params[:id])
        if @course.classroom_matching_id
            @current_matching = ClassroomMatching.find(@course.classroom_matching_id)
        end
        @matchings = ClassroomMatching.where(:enabled => true) 
    end

    def modify_session_data
        if !params[:classroom_match].blank? && !params[:start_date].blank?
            p_colitions = Course.where("classroom_matching_id = #{params[:classroom_match]} and '#{params[:start_date]}' between start_date and end_date")
            if !p_colitions.blank?
                flash[:notice] = "<strong>Error!</strong><br> Ya hay un curso con clases en la fecha seleccionada. Por favor, seleccione otra fecha de inicio u otro horario."
                redirect_to :action => :session_data, :id => params[:courseid]
            else
                course = Course.find(params[:courseid])
                if available_date_for_course(params[:classroom_match], params[:start_date], course.course_template_id)
                    #guardar datos de la sesion
                    course.start_date = params[:start_date]
                    course.classroom_matching_id = params[:classroom_match]
                    course.save!
                    #eliminacion de las sesiones antiguas del curso, si es que las hay
                    CourseSession.where(:commerce_course_id => course.id).destroy_all
                    create_course_sessions(course)
                    redirect_to :action => :assign_teacher, :id => course.id
                else
                    flash[:notice] = "<strong>Error!</strong><br> Existen cursos con horarios asignados para las fechas seleccionadas. Por favor, seleccione otra fecha de inicio u otro horario."
                    redirect_to :action => :session_data, :id => params[:courseid]
                end
            end
        else
            flash[:notice] = "<strong>Error!</strong><br> Debe seleccionar un horario y una fecha de inicio."
            redirect_to :action => :session_data, :id => params[:courseid]
        end
    end

    def edit
        @types = CourseType.all()
        @course = Course.find(params[:id])
        @locations = Location.all()
        if @course.mode
            @products = CourseModeZohoProductMap.where(:enabled => true, :course_mode_id => @course.mode)
        else
            @products = nil
        end
        @modes = CourseMode.where(:enabled => true)
        @templates = CourseTemplate.where(:course_level_id => @course.course_level_id, :deleted => 0)
        @course_levels = CourseLevel.all()
    end

    def update
        @course = Course.find(params[:course][:id])
        @course.update_attributes(course_params)
        if @course.valid?
            redirect_to :action => :session_data, :id => @course.id
        else
            if @course.mode
                @products = CourseModeZohoProductMap.where(:enabled => true, :course_mode_id => @course.mode)
            else
                @products = nil
            end
            @locations = Location.all()
            @modes = CourseMode.where(:enabled => true)
            @types = CourseType.all()
            @course_levels = CourseLevel.all()
            @templates = CourseTemplate.where(:deleted => 0)
            render :edit    
        end
    end

    def assign_teacher
        @course = Course.find(params[:id])
        if @course.classroom_matching_id
            #Si se ha definido el horario y la sala en que el curso
            #se llevara a cabo...
            c_matching = ClassroomMatching.find(@course.classroom_matching_id)
            @week_session_info = ClassroomAvailability.where(:id => c_matching.matching_array.split(","))

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
        else
            flash[:notice] = "Debe definir el horario en que se realizará el curso"
            redirect_to :action => :session_data, :id => @course.id
        end
    end

    def bind_course_teacher
        c = Course.find(params[:courseid])
        c.main_teacher_id = params[:teacherid]
        c.save!
        redirect_to :action => :assign_teacher, :id => params[:courseid], :teacherid => params[:teacherid]
    end

    def show 
        @course = Course.find(params[:id])
        if @course.classroom_matching_id
            cm = ClassroomMatching.find(@course.classroom_matching_id)
            classroom_av_list = cm.matching_array.split(",")
        else
            classroom_av_list= []
        end
        @classroom_disp = ClassroomAvailability.where(:id => classroom_av_list)
        if @course.main_teacher_id
            @teacher = TeacherV.find(@course.main_teacher_id)
        else
            @teacher = nil
        end
        student_list = CourseMember.where(:course_id => @course.id)
        @students = WebUser.where(:id => student_list.map{|s| s.web_user_id})
        @course_statuses = CourseStatus.all()
    end

    def students_login_data
        @course = Course.find(params[:courseid])
        student_list = CourseMember.where(:course_id => @course.id)
        @students = WebUser.where(:id => student_list.map{|s| s.web_user_id})
    end

    def send_moodle_student_data
        begin
            params[:student_ids].each do |student|
                user = WebUser.find(student)
                password = params["password_#{user.id}"]
                #enviar correo con datos
                NotificationMailer.notify_new_user(user,password).deliver
            end
            flash[:notice] = "Los correos con la información de las cuentas de usuario han sido entregados exitosamente"
        rescue => e
            puts e.inspect
            flash[:notice] = "Ocurrió un error al enviar las notificaciones. Pongase en contacto con el administrador del sistema y para notificarle sobre este problema."
        end
        redirect_to :action => :students_login_data, :courseid => params[:courseid]
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
                enrol_student(@new_student.id, params[:courseid])
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
        #se cambia el estado del curso a "en desarrollo"
        course.course_status_id = 3
        course.save!
        begin
            #archivo de estudiantes
            members_attachment = Tempfile.new(["LISTADO_ALUMNOS_#{course.coursename}",".csv"])
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
                #asociar request con el curso
                init_task = CourseInitTask.new()
                init_task.course_id = course.id
                init_task.request_id = req.id
                init_task.save!
            end
            #notificaciones de inicio de curso para los estudiantes registrados
            course_init_notifications(course)
        ensure
            members_attachment.close
            members_attachment.unlink
            course_attachment.close
            course_attachment.unlink
        end
        redirect_to :action => :index, :opt => "desarrollo"
    end

    def change_status
        c = Course.find(params[:id])
        case params[:status]
        when "cancel"
            c.course_status_id = 5
            c.save!
            #cancelar las requests asociadas
            course_tasks = CourseInitTask.where(:course_id => c.id).map{|t| t.request_id}
            course_tasks.each do |r|
                req = Request.find(r)
                req.statusid = 3 #cancelado
                req.save!
            end
        when "activate"
            if c.current_students_qty > 0
                c.count_students
            end
            c.course_status_id = 2
            c.save!
        when "deactivate"
            c.course_status_id = 1
            c.save!
        else
            #finish
            c.course_status_id = 4
            c.save!
        end
        redirect_to :action => :index, :opt => params[:active]
    end

    def cancel_course
        c = Course.find(params[:id])
        #se cancela el curso
        c.update_attributes(:course_status_id => 5)
        redirect_to :action => :index
    end

    def destroy_course
        c = Course.find(params[:id])
        #curso eliminado
        c.destroy
        redirect_to :action => :index, :opt => "cancel"
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

    def course_init_notifications(course)
        students_ids = CourseMember.where(:course_id => course.id).map{|c| c.web_user_id}
        students = WebUser.where(:id => students_ids)
        begin
            students.each do |student|
                NotificationMailer.course_init_student_notification(student, course).deliver
            end
        rescue => e
            puts e.inspect
        end
    end

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
        student_list_headers = ["Nombre", "Apellido", "Rut", "Email", "Género", "Empresa", "Departamento"]
        CSV.open(file.path,"w") do |csv|
            csv << student_list_headers
            members.each do |m|
                csv << [m.firstname, m.lastname, m.rut, m.email, m.gender.include?("male") ? "Masculino" : "Femenino", m.institution, m.department]
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
        desired_days = week_session_info.map{|ws| ws.weekday} #array de dias de clases
        #identificar a los profesores disponibles en las fechas correspondientes
        candidate_teachers = TeacherV.all().map{|t| t.id}
        teachers_availability = UserDisponibility.all()
        if extra
            #revisar horarios extras
            desired_days.each do |day|
                teachers_availability = teachers_availability.where(:user_id => candidate_teachers)
                available_teachers = teachers_availability.where("day_number = #{day} and time('#{week_session_info.where(:weekday => day).first.start_hour}') between time(extra_start_time) and time(extra_end_time)").group("user_id")
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
                available_teachers = teachers_availability.where("day_number = #{day} and time('#{week_session_info.where(:weekday => day).first.start_hour}') between time(start_time) and time(end_time)").group("user_id")
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
        params.require(:web_user).permit(:firstname, :lastname, :rut, :institution, :department, :email, :phone, :gender)
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
        course_list = Course.where(:main_teacher_id => teacherid, :moodleid => nil, :course_status_id => [1,2]).map{|c| c.id}
        return CourseSession.where(:commerce_course_id => course_list)
    end

    def course_session_type_params
        params.require(:course_session_type).permit(:type_name, :description)
    end

    def course_template_params
        params.require(:course_template).permit(:course_level_id, :name, :total_sessions, :starting_book)
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
        c_matching = ClassroomMatching.find(course.classroom_matching_id)
        week_sessions_info = ClassroomAvailability.where(:id => c_matching.matching_array.split(","))
        desired_days = week_sessions_info.map{|wd| wd.weekday}
        for session_number in 1..total_sessions
            new_session = CourseSession.new()
            new_session.commerce_course_id = course.id
            new_session.session_number = session_number
            if session_number == 1
                #solo para la primera sesion
                current_session_date = session_datetime(desired_days, course.start_date, week_sessions_info)
                course.start_date = current_session_date
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
        raw_hour = week_sessions_info.select{|ws| ws.weekday == session_date.wday}.first().start_hour
        #se modifica la hora segun la que se haya registrado
        session_date = session_date.change(:hour => raw_hour.hour.to_i, :min => raw_hour.min.to_i)
        return session_date
    end

    def available_date_for_course(match_id,start_date,template_id)
        c_matching = ClassroomMatching.find(match_id)
        #Sesiones del curso
        total_sessions = CourseTemplate.find(template_id).total_sessions
        #la fecha mas próxima de inicio de un curso
        p_colitions = Course.where("classroom_matching_id = #{match_id} and start_date > '#{start_date}'").order("start_date ASC")
        if p_colitions.blank?
            #si no hay cursos con los que colisionar
            return true
        else
            next_date = p_colitions.first().start_date
        end
        week_session_info = ClassroomAvailability.where(:id => c_matching.matching_array.split(","))
        end_date = course_end_date(week_session_info, start_date, total_sessions)
        if end_date < next_date
            #si el curso termina antes que inicie el siguiente
            return true
        else
            return false
        end
    end

    def course_end_date(week_session_info, start_date, total_sessions)
        holydays = CalendarHolyday.all().map{|h| DateTime.parse(l(h.date, :format => "%d-%m-%Y"))} #array de días en los que no habrá clases 
        desired_days = week_session_info.map{|wd| wd.weekday} #dias en que puede haber clases
        session_date = Date.parse(start_date)
        for count in 1..total_sessions
            if session_date != start_date
                session_date +=1
            end
            session_date+= 1.days while(!desired_days.include?(session_date.wday) || holydays.include?(session_date))
        end
        return session_date #fecha del ultimo dia de clases del curso
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
    	params.require(:course).permit(:coursename, :course_template_id, :description, :course_level_id, :mode, :teacher_user_id, :students_qty, :zoho_product_id, :location_id, :course_type_id, :moodleid)
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
