class CoursesController < ApplicationController
    before_filter :check_authentication
    protect_from_forgery
    layout "dashboard"

    def index
    	@courses = Course.all().order("start_date ASC")
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
    end

    def create
        @course = Course.create(params.permit(:coursename, :description, :mode, :productpriceid, :start_date, :location, :course_type_id))
    	if @course.valid?
            CourseFeature.create(:course_id => @course.id, :feature_name => "first_day", :feature_description => params[:first_weekday])
            CourseFeature.create(:course_id => @course.id, :feature_name => "second_day", :feature_description => params[:second_weekday])
            CourseFeature.create(:course_id => @course.id, :feature_name => "first_day_hour", :feature_description => params[:hour_first_weekday])
            CourseFeature.create(:course_id => @course.id, :feature_name => "second_day_hour", :feature_description => params[:hour_second_weekday])
            raw_products = zoho_product_list
            if raw_products["code"] == 0
                selected_product = raw_products["items"].select{|i| i["name"] == params[:mode]}
                CourseFeature.create(:course_id => @course.id, :feature_name => "price", :feature_description => selected_product[0]["rate"])
            end
    		redirect_to :action => :index
    	else
    		raw_products = zoho_product_list
	    	if raw_products["code"] == 0
	    		@products = raw_products["items"].select{|i| i["status"] == "active"}
	    	else
	    		@products = nil
	    	end
	    	@types = CourseType.all()
	    	render :new
    	end
    end

    private

    def course_params
    	params.require(:course).permit(:coursename, :description, :mode, :productpriceid, :start_date, :location, :moodle_id, :course_type_id)
    end

    def check_authentication
        if session[:user_id].nil?
          redirect_to :controller => "users", :action => "index"
        end
    end

    def get_zoho_data(organization)
        return ZohoOrganizationData.where(:organization_name => organization).first()
    end

    def zoho_product_list
        data = get_zoho_data("Longbourn")
    	url = "https://invoice.zoho.com/api/v3/items?authtoken="+data.authtoken+"&organization_id="+data.organization_id
    	resp = Net::HTTP.get_response(URI.parse(url))
    	return JSON.parse resp.body
    end
end
