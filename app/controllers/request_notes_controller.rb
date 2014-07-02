class RequestNotesController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"

	def show
		@request = Request.find(params[:id])
		@notes = RequestNote.where(:requestid => params[:id])
		@user = User.find(session[:user_id])
		#Se registra la visualizacion de las notas de las solicitudes
		register_last_revision(@request.id, @user.id, "c")
	end

	def create
		rn = RequestNote.create(request_note_params)
		#Se registra la ultima visualizacion del usuario
		register_last_revision(rn.requestid, rn.userid, "u")
		#Se registra el ultimo mensaje de la solicitud
		register_last_message(rn.requestid)
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
		@user = User.find(session[:user_id])
		@request_note = RequestNote.find(params[:id])
	end

	def update
		rn = RequestNote.find(params[:request_note][:id])
		rn.update_attributes(request_note_params)
		#Se registra la ultima visualizacion del usuario
		register_last_revision(rn.requestid, rn.userid, "u")
		#Se registra el ultimo mensaje de la solicitud
		register_last_message(rn.requestid)
		redirect_to :action => "show", :id => params[:request_note][:requestid]
	end

	private

	def check_authentication
	    if session[:user_id].nil?
	      redirect_to :controller => "users", :action => "index"
	    end
	end

	def request_note_params
		params.require(:request_note).permit(:requestid, :userid, :subject, :message, :attach)
	end

	def register_last_revision(request,user,mode)
		case mode
		when "c" #create
			LastRequestMessageCheck.create(:requestid => request, :userid => user, :last_check_datetime => Time.now)
		when "u" #update
			t = LastRequestMessageCheck.where(:requestid => request, :userid => user).first()
			t.update_attributes(:last_check_datetime => Time.now)
		end
	end

	def register_last_message(request)
		r = Request.find(request)
		r.update_attributes(:last_msg_datetime => Time.now)
	end
end
