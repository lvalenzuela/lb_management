class NotificationsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"

	def index
		@notifications = Notification.where(:userid => session[:user_id]).order("id DESC").page(params[:page]).per(5)
		@user = User.find(session[:user_id])
		if params[:selected].nil?
			@selected_notification = nil
		else
			@selected_notification = Notification.find(params[:selected])
		end
	end

	def read
		@selected_notification = Notification.find(params[:id])
		if @selected_notification.seen == 0
			 @selected_notification.update_attributes(:seen => 1)
		end
		@notifications = Notification.where(:userid => session[:user_id]).order("id DESC").page(params[:page]).per(5)
		respond_to do |format|
			format.js
		end
	end

	def search
		@notifications = Notification.where("userid = #{session[:user_id]} and subject like '%#{params[:find][:subject]}%'").order("id DESC").page(params[:page]).per(5)

		respond_to do |format|
			format.js
		end
	end

	def new

	end

	def destroy

	end

	def edit

	end

	def create

	end

	def update

	end

	def show
	end

	private

	def check_authentication
	    if session[:user_id].nil?
	      redirect_to :controller => "users", :action => "index"
	    end
	end
end
