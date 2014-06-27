class RequestsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"
	include RequestsHelper

	def index
		#solicitudes pendientes
		@requests = Request.where(:receiverid => session[:user_id], :statusid => 1).order("updated_at DESC").page(params[:page]).per(10)
		#solocitudes resueltas o canceladas
		@resolved_requests = Request.where(:receiverid => session[:user_id], :statusid => [2,3,4]).order("updated_at DESC")
		@user = User.find(session[:user_id])
		@tags = get_user_tags(@user.id)
	end

	def mark_solution
		#Modifica el estado de la solicitud desde el usuario a quien se le asigna
		change_status(params)

		@requests = Request.where(:receiverid => session[:user_id], :statusid => 1).order("updated_at ASC").page(params[:page]).per(10)
		@resolved_requests = Request.where(:receiverid => session[:user_id], :statusid => [2,3,4]).order("updated_at DESC")
		@tags = get_user_tags(session[:user_id])
		respond_to do |format|
			format.js
		end
	end

	def filter_pending
		if params[:tag] != ""
			@requests = Request.where(:receiverid => session[:user_id], :statusid => 1, :tagid => params[:tag]).order("updated_at ASC").page(params[:page]).per(10)
		else
			@requests = Request.where(:receiverid => session[:user_id], :statusid => 1).order("updated_at ASC").page(params[:page]).per(10)
		end
		@tags = get_user_tags(session[:user_id])
		respond_to do |format|
			format.js
		end
	end

	def filter_resolved
		if params[:tag] != ""
			@resolved_requests = Request.where(:receiverid => session[:user_id], :tagid => params[:tag], :statusid => [2,3,4]).order("updated_at DESC")
		else
			@resolved_requests = Request.where(:receiverid => session[:user_id], :statusid => [2,3,4]).order("updated_at DESC")
		end
		@tags = get_user_tags(session[:user_id])
		respond_to do |format|
			format.js
		end
	end

	def mark_with_tag
		#actualizar campo correspondiente al tag en la solicitud
		#data[1] = id de la solicitud, data[2] = id del tag
		params[:r_tagid].each do |rt|
			if rt != ""
				data = rt.split(";") 
				Request.find(data[0].to_i).update_attributes(:tagid => data[1].to_i)
			end
		end

		#refrescar las solicitudes pendientes
		@requests = Request.where(:receiverid => session[:user_id], :statusid => 1).order("updated_at ASC").page(params[:page]).per(10)
		@tags = get_user_tags(session[:user_id])
		respond_to do |format|
			format.js
		end
	end

	def create_tag
		tag = Tag.create(tag_params)
		if tag.valid?
			flash[:notice] = "La etiqueta fue creada con éxito."
			redirect_to :action => "index"
		else
			flash[:notice] = "No se pudo crear la etiqueta."
			redirect_to :action => "index"
		end
	end

	def sent_requests
		@user = User.find(session[:user_id])
		#solicitudes pendientes, canceladas o resueltas
		@requests = Request.where(:userid => @user.id, :statusid => [1,2,3]).order("updated_at ASC")
		#solicitudes esperando confirmacion
		@conf_requests = Request.where(:userid => @user.id, :statusid => 4).order("updated_at DESC")
		
	end

	def confirm_solution
		#Modifica el estado de la solicitud desde el usuario que realiza la solicitud
		change_status(params)	
		redirect_to :action => "sent_requests"
	end

	def new_request
		@request = Request.new()
		@user = User.where(:id => session[:user_id]).first()
		@priorities = RequestPriority.all()
		#temporalmente limitado a enviar solicitudes sólo al área TI
		@areas = get_areas([4])

		if session[:user_area] == 1 || session[:user_area] == 4
			#Si el usuario TI o Comercial podrá definir un destinatario
			#de TI
			@receivers = receiver_list([1,4])
		else
			#Si es de otra area, se limitaran los subjects de las solicitudes
			#que puede realizar
			@subjects = subject_list()
		end
	end

	def edit_request
		@request = Request.find(params[:id])
		@user = User.find(session[:user_id])
		@priorities = RequestPriority.all()
		@areas = get_areas(4)
		if session[:user_area] == 1 || session[:user_area] == 4
			#Si el usuario TI o Comercial podrá definir un destinatario
			#de TI
			@receivers = receiver_list([1,4])
		else
			#Si es de otra area, se limitaran los subjects de las solicitudes
			#que puede realizar
			@subjects = subject_list()
		end
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
			if !@request.receiverid.nil? && @request.receiverid != ""
				notify_user(@request.receiverid,"Solicitudes","Una solicitud le ha sido asignada.")
			end
			flash[:notice] = "La solicitud fue registrada de forma exitosa."
			redirect_to :action => "sent_requests"
		else
			@user = User.find(session[:user_id])
			flash[:notice] = "No se pudo registrar la solicitud."
			render "new_request"
		end
	end

	def area_requests
		@area = Area.find(params[:id])
		if !@area.nil?
			#mostrar todas las solicitudes pendientes del área
			@a_requests = Request.where("areaid = #{@area.id} and statusid = 1 and receiverid is not NULL and receiverid <> ''").order("updated_at DESC")
			@u_requests = Request.where(:areaid => @area.id, :statusid => 1, :receiverid => [nil, ""]).order("updated_at DESC")
			@receivers = receiver_list(@area.id)
		else
			@a_requests = nil
		end
	end

	def assign_requests
		#asignar requests a las personas seleccionadas 
		params[:requests].each do |r|
			request = Request.find(r)
			request.update_attributes(:receiverid => params[:receiverid], :duedate => params[:duedate])
		end
		redirect_to :action => "area_requests", :id => params[:areaid]
	end

	def show
		@request = Request.find(params[:id])
		@statuses = RequestStatus.all()
		@receivers = receiver_list(@request.areaid)
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

	def change_status(params)
		r = Request.find(params[:id])
		
		r.update_attributes(:statusid => params[:statusid])
		
		case r.statusid
		when 1
			notify_user(r.userid,"Solicitud Pendiente","Una solicitud en espera de confirmación se le ha vuelto a asignar. Por favor, revise sus solicitudes.")
		when 2
			notify_user(r.userid,"Solicitud Confirmada","Una solicitud con el tema '"+r.subject+"' ha sido confirmada y se ha registrado como resuelta.")
		when 3
			notify_user(r.userid,"Solicitud Cancelada","Una solicitud con el tema '"+r.subject+"' ha sido cancelada.")
		when 4
			#se marca la solicitud como esperando confirmacion
			notify_user(r.userid,"Solicitud Esperando Confirmación","Una solicitud con el tema '"+r.subject+"' ha sido marcada como resuelta y está esperando confirmación. Por favor, revise sus solicitudes enviadas.")
			#se marca la fecha en que la solicitud fue marcada como solucionada
			r.update_attributes(:resolved_at => Date.current())
		end
	end

	def receiver_list(area_list)
		areas = Area.where(:id => area_list)
		area_names = []
		areas.each do |a|
			area_names << a.areaname
		end
		receiverlist = User.where(:institution => "Longbourn Institute", :department => area_names) 
	end

	def get_areas(id_list)
		#se especifican las areas a mostrar.
		#si no se especifica nada, se muestran todas
		if id_list.nil? || id_list == ""
			Area.all()
		else
			Area.where(:id => id_list)
		end
	end

	def get_user_tags(userid)
		tags = Tag.where(:userid => [userid,0])
		if tags.nil? || tags.empty?
			{}
		else
			tags
		end
	end

	def check_authentication
	    if session[:user_id].nil?
	      redirect_to :controller => "users", :action => "index"
	    end
	end

	def tag_params
		params.require(:tag).permit(:userid, :tagname)
	end

	def request_params
		params.require(:request).permit(:userid, :subject, :receiverid, :areaid, :priorityid, :statusid, :request, :attach, :pic)
	end

	def notify_user(userid, subject, message)
		n = Notification.new(:userid => userid, :subject => subject, :message => message, :seen => 0)
		n.save		
	end

	def subject_list
		#listado de subjects que otras areas pueden hacer al área TI
		subjects = {"Habilitación nuevo iPad" => "Habilitación nuevo iPad",
					"Habilitación Nuevo PC" => "Habilitación Nuevo PC",
					"Problema iPad" => "Problema iPad",
					"Problema PC" => "Problema PC",
					"Creación Nuevo Curso en Moodle" => "Creación Nuevo Curso en Moodle",
					"Modificación de Asistencias de Curso" => "Modificación de Asistencias de Curso", 
					"Registrar Incorporacion / Deserción de Alumno" => "Registrar Incorporacion / Deserción de Alumno",
					"Problemas de Acceso a Web / Mail Longbourn" => "Problemas de Acceso a Web / Mail Longbourn",
					"Error en Material de Curso" => "Error en Material de Curso",
					"Otro" => "Otro"}
	end
end
