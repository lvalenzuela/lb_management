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
        @teachers = get_teachers_list
    end

    def create
        @course = Course.create(course_params)
    	if @course.valid?
            #generacion de course_features
            modify_course_features
            redirect_to :action => :index
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
	    	render :new
    	end
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
        @course_levels = CourseLevel.all()
        @teachers = get_teachers_list
    end

    def update
        @course = Course.find(params[:course][:id])
        @course.update_attributes(course_params)
        if @course.valid?
            #modificacion de course_features
            modify_course_features
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

    private

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

    def get_teachers_list
        c = get_area_context(2)
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

    def get_area_context(areaid)
        #Area docente ID = 2
        return Context.where(:typeid => 2, :instanceid => areaid).first()
    end

    def course_params
    	params.require(:course).permit(:coursename, :description, :course_level_id, :mode, :teacher_user_id, :students_qty, :zoho_product_id, :start_date, :location, :course_type_id)
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
