class RequestsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"
	include RequestsHelper

	def index
		@requests = Request.where(:receiverid => session[:user_id])
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
		@requests = Request.where(:userid => session[:user_id])
	end

	def new_request
		@request = Request.new()
		@user = User.where(:id => session[:user_id]).first()
	end

	def edit_request
		@request = Request.find(params[:id])
		@user = User.find(session[:user_id])
	end

	def update
		@request = Request.find(params[:request][:id])
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
		@request = Request.create(request_params)
		if @request.valid?
			flash[:notice] = "La solicitud fue registrada de forma exitosa."
			redirect_to :action => "sent_requests"
		else
			@user = User.find(session[:user_id])
			flash[:notice] = "No se pudo registrar la solicitud."
			render "new_request"
		end
	end

	def area_requests
		@area = RequestArea.where(:area_manager => session[:user_id]).first()
		if !@area.nil?
			@requests = Request.where(:areaid => @area.id, :receiverid => nil).order("created_at DESC").page(params[:page]).per(5)
		else
			@requests = nil
		end
	end

	def assign_requests
		#asignar requests a las personas seleccionadas 
		params[:requests].each do |r|
			request = Request.find(r)
			request.update!(params.permit(:receiverid))
		end

		@area = RequestArea.where(:area_manager => session[:user_id]).first()
		@requests = Request.where(:areaid => @area.id, :receiverid => nil).order("created_at DESC").page(params[:page]).per(5)
		
		respond_to do |format|
			format.js
		end
	end

	def show
		@request = Request.find(params[:id])
	end

	def destroy
		request = Request.find(params[:id])
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
	      redirect_to :controller => "users", :action => "index"
	    end
	end

	def request_params
		params.require(:request).permit(:userid, :subject, :receiverid, :areaid, :priorityid, :statusid, :request, :duedate)
	end

	def notification_params
		params.require(:notification).permit(:userid, :subject, :message, :seen)
	end

	def notify_user(userid, subject, message)
		params[:notification] = { :userid => userid, :subject => subject, :message => message, :seen => 0 }
		Notification.create(notification_params)
	end
end
