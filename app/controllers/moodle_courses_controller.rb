class MoodleCoursesController < ApplicationController
    before_filter :check_authentication
    protect_from_forgery
    layout "dashboard"

    def index
    	@courses = MoodleCourse.all()
    end

    def assign

    end

    def create_group
        
    end

    private

    def check_authentication
        if session[:user_id].nil?
          redirect_to :controller => "users", :action => "index"
        end
    end
end
