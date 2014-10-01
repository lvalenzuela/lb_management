class CoursesController < ApplicationController
    before_filter :check_authentication
    protect_from_forgery
    layout "dashboard"

    def index
        case params[:opt]
        when "ongoing"
            @courses = Course.where(:course_status_id => 4).order("start_date ASC")
            @active = "ongoing"
        when "sold"
            @courses = Course.where(:course_status_id => 2).order("start_date ASC")
            @active = "sold"
        when "canceled"
            @courses = Course.where(:course_status_id => 3).order("start_date ASC")
            @active = "canceled"
        else
    	   @courses = Course.where(:course_status_id => [1,2]).order("start_date ASC")
           @active = "staged"
        end
    end

    def template_selector_options
        @templates = CourseTemplate.where(:course_level_id => params[:courselevel], :deleted => 0)
        respond_to do |format|
            format.js
        end
    end

    def new
    	raw_products = zoho_product_list
    	if raw_products["code"] == 0
    		@products = raw_products["items"].select{|i| i["status"] == "active"}
    	else
    		@products = nil
    	end
    	@types = CourseType.all()
    	@course = Course.new()
        @course_levels = CourseLevel.all()
        @templates = nil
        @teachers = get_teachers_list
    end

    def create
        @course = Course.create(course_params)
    	if @course.valid?
            #generacion de course_features
            modify_course_features
            #creacion de las sesiones correspondientes al curso
            create_course_sessions(@course)
            redirect_to :action => :assign_teacher, :id => @course.id
    	else
    		raw_products = zoho_product_list
	    	if raw_products["code"] == 0
	    		@products = raw_products["items"].select{|i| i["status"] == "active"}
	    	else
	    		@products = nil
	    	end
	    	@types = CourseType.all()
            @teachers = get_teachers_list
            @course_levels = CourseLevel.all()
            @templates = CourseTemplate.where(:deleted => 0)
	    	render :new
    	end
    end

    def assign_teacher
        @course = Course.find(params[:id])
        @features = CourseFeature.where(:course_id => params[:id])
        day1 = @features.find_by_feature_name('first_day').feature_description.to_i
        day1_hour = @features.find_by_feature_name('first_day_hour').feature_description
        day2 = @features.find_by_feature_name('second_day').feature_description.to_i
        day2_hour = @features.find_by_feature_name('second_day_hour').feature_description
        tchrs = UserDisponibility.where("day_number = #{day1} 
                                        and time('#{day1_hour}') between time(start_time) and time(end_time)
                                        and user_id in 
                                        (select user_id 
                                            from user_disponibilities 
                                            where day_number = #{day2}
                                                and time('#{day2_hour}') between time(start_time) and time(end_time))")
        @teachers = TeacherV.where(:id => tchrs.map{|t| t.user_id})
    end

    def show 
        @course = Course.find(params[:id])
        @course_features = CourseFeature.where(:course_id => @course.id)
        student_list = CourseMember.where(:course_id => @course.id)
        @students = WebUser.where(:id => student_list.map{|s| s.web_user_id})
    end

    def edit
        raw_products = zoho_product_list
        if raw_products["code"] == 0
            @products = raw_products["items"].select{|i| i["status"] == "active"}
        else
            @products = nil
        end
        @types = CourseType.all()
        @course = Course.find(params[:id])
        @course_features = CourseFeature.where(:course_id => @course.id)
        @templates = CourseTemplate.where(:course_level_id => @course.course_level_id, :deleted => 0)
        @course_levels = CourseLevel.all()
        @teachers = get_teachers_list
    end

    def update
        @course = Course.find(params[:course][:id])
        @course.update_attributes(course_params)
        if @course.valid?
            #modificacion de course_features
            modify_course_features
            #eliminacion de las sesiones antiguas del curso
            CourseSession.where(:commerce_course_id => @course.id).destroy_all
            #creacion de las nuevas sesiones correspondientes al curso
            create_course_sessions(@course)
            redirect_to :action => :index
        else
            raw_products = zoho_product_list
            if raw_products["code"] == 0
                @products = raw_products["items"].select{|i| i["status"] == "active"}
            else
                @products = nil
            end
            @types = CourseType.all()
            @course_features = CourseFeature.where(:course_id => @course.id)
            @teachers = get_teachers_list
            @course_levels = CourseLevel.all()
            render :edit    
        end
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

    def course_session_type_params
        params.require(:course_session_type).permit(:type_name, :description)
    end

    def course_template_params
        params.require(:course_template).permit(:course_level_id,:name,:total_sessions)
    end

    def modify_course_features
        cf = CourseFeature.where(:course_id => @course.id, :feature_name => "first_day").first()
        if cf
            cf.update_attributes(:feature_description => params[:first_weekday])
        else
            CourseFeature.create(:course_id => @course.id, :feature_name => "first_day", :feature_description => params[:first_weekday])
        end
        cf = CourseFeature.where(:course_id => @course.id, :feature_name => "first_day_hour").first()
        
        if cf
            cf.update_attributes(:feature_description => params[:hour_first_weekday])
        else
            CourseFeature.create(:course_id => @course.id, :feature_name => "first_day_hour", :feature_description => params[:hour_first_weekday])
        end

        cf = CourseFeature.where(:course_id => @course.id, :feature_name => "second_day").first()
        if cf
            cf.update_attributes(:feature_description => params[:second_weekday])
        else
            CourseFeature.create(:course_id => @course.id, :feature_name => "second_day", :feature_description => params[:second_weekday])
        end

        cf = CourseFeature.where(:course_id => @course.id, :feature_name => "second_day_hour").first()
        if cf
            cf.update_attributes(:feature_description => params[:hour_second_weekday])
        else
            CourseFeature.create(:course_id => @course.id, :feature_name => "second_day_hour", :feature_description => params[:hour_second_weekday])
        end

        selected_item = zoho_get_element("items",@course.zoho_product_id)
        if selected_item["code"] == 0
            cf = CourseFeature.where(:course_id => @course.id, :feature_name => "price").first()
            if cf
                cf.update_attributes(:feature_description => selected_item["item"]["rate"])
            else
                CourseFeature.create(:course_id => @course.id, :feature_name => "price", :feature_description => selected_item["item"]["rate"])
            end
        end
    end

    def create_course_sessions(course)
        #Se crean las sesiones correspondientes al curso 
        #aun no se le asocia ningun curso de moodle
        total_sessions = CourseTemplate.find(course.course_template_id).total_sessions.to_i
        day1 = CourseFeature.where(:course_id => course.id, :feature_name => "first_day").first().feature_description.to_i
        hour_day1 = CourseFeature.where(:course_id => course.id, :feature_name => "first_day_hour").first().feature_description
        day2 = CourseFeature.where(:course_id => course.id, :feature_name => "second_day").first().feature_description.to_i
        hour_day2 = CourseFeature.where(:course_id => course.id, :feature_name => "second_day_hour").first().feature_description
        for session_number in 1..total_sessions
            new_session = CourseSession.new()
            new_session.commerce_course_id = course.id
            new_session.session_number = session_number
            if session_number == 1
                current_session_date = session_datetime(course.start_date,day1,day2,hour_day1,hour_day2)
            else
                current_session_date = session_datetime(current_session_date + 1.days,day1,day2,hour_day1,hour_day2)
            end
            new_session.startdatetime = current_session_date
            new_session.save!
        end
        #ultima sesion del curso corresponde a la fecha de término del mismo
        course.end_date = current_session_date
        course.save!
    end

    def session_datetime(session_date, day1, day2, hour_day1, hour_day2)
        desired_days = [day1,day2]
        session_date = DateTime.parse(l(session_date, :format => "%d-%m-%Y"))
        session_date += 1.days while !desired_days.include?(session_date.wday)
        if session_date.wday == day1
            hour = hour_day1.split(":")
            session_date = session_date.change(:hour => hour[0].to_i, :min => hour[1].to_i)
        else
            hour = hour_day2.split(":")
            session_date = session_date.change(:hour => hour[0].to_i, :min => hour[1].to_i)
        end
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
    	params.require(:course).permit(:coursename, :course_template_id, :description, :course_level_id, :mode, :teacher_user_id, :students_qty, :zoho_product_id, :start_date, :location, :course_type_id)
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
