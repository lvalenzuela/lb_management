class RequestNotesController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"

	def show
		@request = Request.find(params[:id])
		@notes = RequestNote.where(:requestid => params[:id])
	end

	def create

	end

	def edit

	end

	private

	def check_authentication
	    if session[:user_id].nil?
	      redirect_to :controller => "users", :action => "index"
	    end
	end
end
