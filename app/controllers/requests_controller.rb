class RequestsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"
	include RequestsHelper

	def index
		@active = "pending"
		case params[:opt] 
		when "solved"
			@active = "solved"
		end
		#solicitudes pendientes
		@requests = Request.where(:receiverid => session[:user_id], :statusid => [1,4]).order("updated_at DESC").page(params[:page]).per(10)
		#solocitudes resueltas o canceladas
		@resolved_requests = Request.where(:receiverid => session[:user_id], :statusid => [2,3,]).order("updated_at DESC")
		@user = User.find(session[:user_id])
		@tags = get_user_tags(@user.id)
	end

	def mark_solution
		#Modifica el estado de la solicitud desde el usuario a quien se le asigna
		change_status(params)

		redirect_to :action => params[:actionname]
	end

	def filter_pending
		if params[:tag] != ""
			@requests = Request.where(:receiverid => session[:user_id], :statusid => [1,4], :tagid => params[:tag]).order("updated_at ASC").page(params[:page]).per(10)
		else
			@requests = Request.where(:receiverid => session[:user_id], :statusid => [1,4]).order("updated_at ASC").page(params[:page]).per(10)
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

		redirect_to :action => params[:actionname]
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
		#Hay dos tipos de tabla
		#La primera es una tabla regular que muestra solicitudes
		#la segunda corresponde a la tabla con los botones para confirmar o reenviar solicitudes
		@table = 1
		@editable = false
		@active = "wconf"
		case params[:f]
		when "inprogress"
			#Solicitudes pendientes que han sido asignadas
			@active = "inprogress"
			@requests = Request.where("userid = #{@user.id} and receiverid is not null and statusid = 1").order("updated_at ASC")
		when "solved"
			#Solicitudes resueltas o canceladas
			@active = "solved"
			@requests = Request.where("userid = #{@user.id} and statusid in (2,3)").order("updated_at ASC")
		when "unassigned"
			#Solicitudes pendientes que no han sido asignadas
			@active = "unassigned"
			@editable = true
			@requests = Request.where("userid = #{@user.id} and receiverid is null and statusid = 1").order("updated_at ASC")
		else
			@requests = Request.where("userid = #{@user.id} and statusid = 4").order("updated_at ASC")
			@table = 2
		end
	end

	def confirm_solution
		#Modifica el estado de la solicitud desde el usuario que realiza la solicitud
		change_status(params)	
		redirect_to :action => "sent_requests"
	end

	def area_for_request
		@areas = get_areas(default_area)
	end

	def new_request
		@request = Request.new()
		@user = User.where(:id => session[:user_id]).first()
		@priorities = RequestPriority.all()
		#temporalmente limitado a enviar solicitudes sólo al área TI
		@area = Area.find(params[:areaid])
		role = area_role(@user.id, @area.id)
		if role
			if role <= 2
				#Si el usuario es administrador o manager del sistema
				@manager = true
			elsif role <= 3
				#es un miembro del area, asi que puede enviar solicitudes a una persona en específico
				@receivers = receiver_list(default_area)
			else
				#Si es de otra area, se limitaran los subjects de las solicitudes
				#que puede realizar
				@subjects = subject_list()
			end
		else
			@subjects = subject_list()
		end
	end

	def edit_request
		@request = Request.find(params[:id])
		@user = User.find(session[:user_id])
		@priorities = RequestPriority.all()
		@area = Area.find(@request.areaid)
		role = area_role(@user.id, @area.id)
		if role <= 2
			#Si el usuario es administrador o manager del sistema
			@manager = true
		end
		if role <= 3
			#es un miembro del area, asi que puede enviar solicitudes a una persona en específico
			@receivers = receiver_list(default_area)
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
				notify_user(@request.receiverid,@request,true)
			else
				#se notifica a todos los administradores de area que hay 
				#una nueva solicitud pendiente
				get_area_managers(@request.areaid).each do |m|
					NotificationMailer.request_for_area(m,@request).deliver
				end
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
			case params[:f]
			when "assigned"
				#sólo las solicitudes asignadas
				@active = "assigned"
				@requests = Request.where("areaid = #{@area.id} and statusid = 1 and receiverid is not NULL and receiverid <> ''").order("updated_at DESC")
			when "unassigned"
				#solo solicitudes sin asignar
				@active = "unassigned"
				@requests = Request.where(:areaid => @area.id, :statusid => 1, :receiverid => [nil, ""]).order("updated_at DESC")
			else
				#todas las solicitudes
				@active = "all"
				@requests = Request.where(:areaid => @area.id, :statusid => 1).order("updated_at DESC")
			end
			@receivers = receiver_list(@area.id)
		else
			@requests = nil
		end
	end

	def assign_requests
		if params[:requests]
			#asignar requests a las personas seleccionadas
			params[:requests].each do |r|
				request = Request.find(r)
				if params[:receiverid] != ""
					request.update_attributes(:receiverid => params[:receiverid], :duedate => params[:duedate])
				else
					flash[:notice] = "Debe seleccionar un usuario a quien asignar la solicitud."
				end
			end
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

	#####################
	#Functiones Privadas#
	#####################
	private

	def area_role(userid, areaid)
		c_id = Context.where(:typeid => 2, :instanceid => areaid).first().id
		role = RoleAssignation.where(:contextid => c_id, :userid => userid).first()
		if role.nil? || role.blank?
			return nil
		else
			return role.roleid
		end
	end

	def get_area_managers(area)
		c = Context.where(:typeid => 2, :instanceid => area).first()
		return User.joins("inner join role_assignations
						on role_assignations.userid = users.id
						and role_assignations.contextid = #{c.id}
						and role_assignations.roleid in (1,2)")
	end

	def change_status(params)
		r = Request.find(params[:id])
		
		r.update_attributes(:statusid => params[:statusid])
		if r.statusid == 4
			#Si la solicitud fue resuelta
			#se marca la fecha en que la solicitud fue marcada como solucionada
			r.update_attributes(:resolved_at => Date.current())
		end
		notify_user(r.userid,r,false)
	end

	def receiver_list(area)
		c = Context.where(:typeid => 2, :instanceid => area).first()

		return User.joins("inner join role_assignations
						on role_assignations.userid = users.id
						and role_assignations.contextid = #{c.id}").select("users.id,
																			users.firstname,
																			users.lastname,
																			role_assignations.roleid").order("roleid ASC")
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
		params.require(:request).permit(:userid, :subject, :receiverid, :areaid, :priorityid, :statusid, :duedate, :request, :attach, :pic)
	end

	def notify_user(userid,request,new_request)
		@user = User.find(userid)
		case request.statusid
		when 1
			if new_request
				subject = "Solicitud Asignada"
				message = "Una solicitud le ha sido asignada. Por favor, revise sus solicitudes."
				NotificationMailer.assigned_request(@user,request).deliver
			else
				subject = "Solicitud Pendiente"
				message = "Una solicitud en espera de confirmación se le ha vuelto a asignar. Por favor, revise sus solicitudes."
				NotificationMailer.reassigned_request(@user,request).deliver
			end

		when 2
			subject = "Solicitud Confirmada"
			message = "Una solicitud con el tema '"+request.subject+"' ha sido confirmada y se ha registrado como resuelta."
			#NotificationMailer.confirmed_request(@user,request).deliver
		when 3
			subject = "Solicitud Cancelada"
			message = "Una solicitud con el tema '"+request.subject+"' ha sido cancelada."
			NotificationMailer.canceled_request(@user,request).deliver
		when 4
			subject = "Solicitud Esperando Confirmación"
			message = "Una solicitud con el tema '"+request.subject+"' ha sido marcada como resuelta y está esperando confirmación. Por favor, revise sus solicitudes enviadas."
			NotificationMailer.waiting_request(@user,request).deliver
		end
		Notification.create(:userid => userid, :subject => subject, :message => message)
	end

	def subject_list
		#listado de subjects que otras areas pueden hacer al área TI
		subjects = {#"Habilitación nuevo iPad" => "Habilitación nuevo iPad",
					#"Habilitación Nuevo PC" => "Habilitación Nuevo PC",
					#"Problema iPad" => "Problema iPad",
					#"Problema PC" => "Problema PC",
					"Solicitud de Incorporación / Eliminación de Estudiante a Curso" => "Solicitud de Incorporación / Eliminación de Estudiante a Curso",
					"Solicitud de Incorporación / Eliminación de Profesor a Curso" => "Solicitud de Incorporación / Eliminación de Profesor a Curso",
					"Solicitud de Creación de Nuevo Curso en Web Estudiantes" => "Solicitud de Creación de Nuevo Curso en Web Estudiantes",
					"Problemas de acceso a la Web / Mail" => "Problemas de acceso a la Web / Mail",
					"Notificación de Error detectado en Material Web" => "Notificación de Error detectado en Material Web",
					"Notificación de Problema detectado en Portal Summit" => "Notificación de Problema detectado en Portal Summit"}
	end

	def default_area
		area = [4]
	end
end
