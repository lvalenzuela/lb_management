class RequestsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"
	include RequestsHelper

	def index
		if params[:r_filter]
			@requests = requests_for_user(params[:r_filter][:r_area],params[:r_filter][:status],params[:r_filter][:priority])
		else
			@requests = requests_for_user(nil,nil,nil)
		end
	end

	def filter_requests
		if params[:r_filter]
			@requests = requests_for_user(params[:r_filter][:r_area],params[:r_filter][:status],params[:r_filter][:priority])
		else
			@requests = requests_for_user(nil,nil,nil)
		end
		
		respond_to do |format|
			format.js
		end
	end

	def sent_requests

	end

	def new_request
		@request = ManagementRequest.new()
		@user = User.where(:id => session[:user_id]).first()
		@lb_areas = ManagementRequestArea.all()
		@priorities = ManagementRequestPriority.all()
	end

	def update_request
		request = ManagementRequest.find(params[:management_request][:id])
		if request.update_attributes(request_params)
			flash[:notice] = "Estado de la solicitud modificado."
			redirect_to :action => "index"
		else
			flash[:notice] = "No se pudo modificar el estado de la solicitud."
			redirect_to :action => "index"
		end
	end

	def create_request
		@request = ManagementRequest.create(request_params)
		if @request.valid?
			flash[:notice] = "La solicitud fue registrada de forma exitosa."
			redirect_to :action => "index"
		else
			flash[:notice] = "No se pudo registrar la solicitud."
			redirect_to :action => "new_request"
		end
	end

	def show
		@request = get_request(params[:id])
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

	def request_params
		params.require(:management_request).permit(:userid, :subject, :receiverid, :receiverarea, :priority, :status, :request, :duedate)
	end
end
