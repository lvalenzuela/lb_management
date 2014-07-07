class RequestNotesController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"

	def show
		@request = Request.find(params[:id])
		@notes = RequestNote.where(:requestid => params[:id])
		c_time = Time.now #el mismo tiempo para ambos registros
		#Se registra la visualizacion de las notas de las solicitudes
		register_last_revision(@request.id,session[:user_id],c_time)
	end

	def create
		rn = RequestNote.create(request_note_params)
		c_time = Time.now #el mismo tiempo para ambos registros
		#Se registra el ultimo mensaje de la solicitud
		register_last_message(rn.requestid,c_time)
		#Se registra la ultima visualizacion del usuario
		register_last_revision(rn.requestid, rn.userid,c_time)
		#notificacion por mail
		notify_new_note(rn.requestid,rn.userid)
		if rn.valid?
			redirect_to :action => "show", :id => rn.requestid
		else
			#eventualmente lo modificaré para que entregue los posibles errores
			#no me presionen
			redirect_to :action => "show", :id => rn.requestid
		end
	end

	def edit
		@request = Request.find(params[:requestid])
		@notes = RequestNote.where(:requestid => params[:requestid])
		@request_note = RequestNote.find(params[:id])
	end

	def update
		rn = RequestNote.find(params[:request_note][:id])
		rn.update_attributes(request_note_params)
		c_time = Time.now #el mismo tiempo para ambos registros
		#Se registra la ultima visualizacion del usuario
		register_last_revision(rn.requestid, rn.userid,c_time)
		#Se registra el ultimo mensaje de la solicitud
		register_last_message(rn.requestid,c_time)
		redirect_to :action => "show", :id => params[:request_note][:requestid]
	end

	private

	def notify_new_note(requestid,userid)
		r = Request.find(requestid)
		if r.userid == userid
			#el usuario que escribe el mensaje es el mismo que envía la solicitud
			user = User.find(r.receiverid)
		else
			#el usuario que escribe el mensaje es el receptor de la solicitud
			user = User.find(r.userid)
		end
		NotificationMailer.new_forum_msg(user,r).deliver
	end

	def check_authentication
	    if session[:user_id].nil?
	      redirect_to :controller => "users", :action => "index"
	    end
	end

	def request_note_params
		params.require(:request_note).permit(:requestid, :userid, :subject, :message, :attach)
	end

	def register_last_revision(request,user,c_time)
		t = LastRequestMessageCheck.where(:requestid => request, :userid => user)
		if !t.nil?
			t.destroy_all
		end
		LastRequestMessageCheck.create(:requestid => request, :userid => user, :last_check_datetime => c_time)
	end

	def register_last_message(request,c_time)
		r = Request.find(request)
		r.update_attributes(:last_msg_datetime => c_time)
	end
end
