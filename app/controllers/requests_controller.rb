class RequestsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"
	include RequestsHelper

	def index
		if params[:own_requests].nil?
			@requests = get_pending_requests()
		else
			@requests = ManagementRequest.where(:target_user => session[:user_id], :status => 1)
		end
	end

	def new_request
		@user = User.where(:id => session[:user_id]).first()
		@target_users = User.where("username like '%@longbourn.cl' and deleted = 0")
		@priorities = ManagementRequestPriority.all()
	end

	def create_request
		if params[:request]
			ManagementRequest.create(management_request_params)
			flash[:notice] = "La solicitud fue registrada de forma exitosa."
			redirect_to :action => "index"
		else
			flash[:notice] = "No se pudo registrar la solicitud."
			redirect_to :action => "new_request"
		end
	end

	def show
		@request = get_request(params[:requestid])
	end

	def destroy
		if session[:user_id] == 182
			ManagementRequest.where(:id => params[:id]).destroy_all
			flash[:notice] = "La solicitud fue eliminada de forma exitosa."
			redirect_to :action => "index"
		else
			flash[:notice] = "No estas autorizado para eliminar solicitudes."
			redirect_to :action => "index"
		end
	end

	private

	def check_authentication
	    if session[:user_id].nil?
	      redirect_to :controller => "main", :action => "index"
	    end
	end

	def management_request_params
		params.require(:request).permit(:userid, :subject, :target_user, :priority, :status, :request)
	end
end
