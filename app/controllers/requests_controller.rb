class RequestsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"
	include RequestsHelper

	def index
		@requests = ManagementRequest.where(:receiverid => session[:user_id])
		@user = User.find(session[:user_id])
	end

	def all_requests
		if params[:r_filter]
			@requests = requests_list(params[:r_filter][:r_area],params[:r_filter][:status],params[:r_filter][:priority],nil)
		else
			@requests = requests_list(nil,nil,nil,nil)
		end
	end

	def filter_requests
		if params[:r_filter]
			@requests = requests_list(params[:r_filter][:r_area],params[:r_filter][:status],params[:r_filter][:priority],nil)
		else
			@requests = requests_list(nil,nil,nil,nil)
		end
		
		respond_to do |format|
			format.js
		end
	end

	def sent_requests
		@user = User.find(session[:user_id])
		@requests = ManagementRequest.where(:userid => session[:user_id])
	end

	def new_request
		@request = ManagementRequest.new()
		@user = User.where(:id => session[:user_id]).first()
	end

	def edit_request
		@request = ManagementRequest.find(params[:id])
		@user = User.find(session[:user_id])
	end

	def update
		@request = ManagementRequest.find(params[:management_request][:id])
		old_receiverid = @request.receiverid
		if @request.update_attributes(request_params)
			if !@request.receiverid.nil? && old_receiverid != @request.receiverid
				notify_user(@request.receiverid,"Solicitudes","Una solicitud le ha sido asignada.")
			end
			flash[:notice] = "La solicitud ha sido modificada."
			redirect_to :action => "sent_requests"
		else
			flash[:notice] = "No ha podido modificar la solicitud."
			@user = User.find(session[:user_id])
			render "edit_request"
		end
	end

	def create_request
		@request = ManagementRequest.create(request_params)
		if @request.valid?
			flash[:notice] = "La solicitud fue registrada de forma exitosa."
			redirect_to :action => "sent_requests"
		else
			@user = User.find(session[:user_id])
			flash[:notice] = "No se pudo registrar la solicitud."
			render "new_request"
		end
	end

	def show
		@request = ManagementRequest.find(params[:id])
	end

	def destroy
		request = ManagementRequest.find(params[:id])
		if request.userid == session[:user_id]
			request.destroy
			flash[:notice] = "La solicitud fue eliminada de forma exitosa."
			redirect_to :action => "sent_requests"
		else
			flash[:notice] = "No estas autorizado para eliminar solicitudes."
			redirect_to :action => "sent_sequests"
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

	def notification_params
		params.require(:management_notification).permit(:userid, :subject, :notification, :read)
	end

	def notify_user(userid, subject, message)
		params[:management_notification] = { :userid => userid, :subject => subject, :notification => message, :read => 0 }
		ManagementNotification.create(notification_params)
	end
end
