class NotificationsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"

	def index
		if params[:id].nil?
			@selected = nil
		else
			@selected = Notification.find(params[:id])
			@selected.update_attributes(:seen => 1)
		end
		@notifications = Notification.where(:userid => session[:user_id]).order("id DESC").page(params[:page]).per(10)
		@user = User.find(session[:user_id])
	end

	def read
		@selected = Notification.find(params[:id])
		if @selected.seen == 0
			 @selected.update_attributes(:seen => 1)
		end
		@notifications = Notification.where(:userid => session[:user_id]).order("id DESC").page(params[:page]).per(10)
		respond_to do |format|
			format.js
		end
	end

	def search
		@notifications = Notification.where("userid = #{session[:user_id]} and subject like '%#{params[:find][:subject]}%'").order("id DESC").page(params[:page]).per(10)

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

	def mark_as_read
	end
end
