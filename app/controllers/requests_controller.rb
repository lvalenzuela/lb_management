class RequestsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"

	def index

	end

	def new_request
		@user = User.where(:id => session[:user_id]).first()
	end

	def create_request
		if params[:request]
			ManagementRequest.create(management_request_params)
			flash[:notice] = "Solicitud registrada,"
			redirect_to :action => "index"
		else
			redirect_to :action => "new_request"
		end
	end

	private

	def check_authentication
	    if session[:user_id].nil?
	      redirect_to :controller => "main", :action => "index"
	    end
	end

	def management_request_params
		params.require(:request).permit(:userid, :subject, :priority, :status, :request)
	end
end
