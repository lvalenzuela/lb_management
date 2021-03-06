class RequestsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"
	include RequestsHelper

	def search
		if params
			@previous_action = params[:parent_action]
			@active = "search"
			@search_term = params[:search_term]
			case params[:parent_action]
			when "area_requests"
				@area = Area.find(params[:id])
				@requests = Request.where(:areaid => @area.id).order("updated_at DESC").page(params[:page]).per(10)
				action_to_render = "area_requests"
			when "sent_requests"
				#Se busca entre los requerimientos enviados
				@requests = Request.where("userid = #{current_user.id} and request like '%#{@search_term}%'").page(params[:page]).per(10)
				action_to_render = "sent_requests"
			else
				#Se busca entre los requerimientos recividos
				@requests = Request.where("receiverid = #{current_user.id} and request like '%#{@search_term}%'").page(params[:page]).per(10)
				action_to_render = "index"
			end
			render "requests/"+action_to_render
		else
			redirect_to :index
		end
	end

	def index
		@active = "pending"
		case params[:opt] 
		when "solved"
			@active = "solved"
			#solocitudes resueltas o canceladas
			@requests = Request.where(:receiverid => current_user.id, :statusid => [2,3]).order("updated_at DESC").page(params[:page]).per(10)
		when "wconf"
			#solicitudes esperando confirmacion
			@active = "wconf"
			@requests = Request.where(:receiverid => current_user.id, :statusid => [4]).order("updated_at DESC").page(params[:page]).per(10)
		else
			#solicitudes pendientes
			@requests = Request.where(:receiverid => current_user.id, :statusid => [1]).order("updated_at DESC").page(params[:page]).per(10)
		end
		@user = current_user
	end

	def bulk_request_status_change

	end

	def mark_solution
		#Modifica el estado de la solicitud desde el usuario a quien se le asigna
		change_status(params)

		redirect_to :controller => :request_notes, :action => :show, :id => params[:id]
	end

	def sent_requests
		@user = current_user
		#Hay dos tipos de tabla
		#La primera es una tabla regular que muestra solicitudes
		#la segunda corresponde a la tabla con los botones para confirmar o reenviar solicitudes
		@active = "wconf"
		case params[:f]
		when "solved"
			#Solicitudes resueltas o canceladas
			@active = "solved"
			@requests = Request.where("userid = #{@user.id} and statusid in (2,3)").order("updated_at DESC").page(params[:page]).per(10)
		when "unassigned"
			#Solicitudes pendientes que no han sido asignadas
			@active = "unassigned"
			@requests = Request.where("userid = #{@user.id} and receiverid is null and statusid = 1").order("updated_at DESC").page(params[:page]).per(10)
		when "inprogress"
			@active = "inprogress"
			@requests = Request.where("userid = #{@user.id} and receiverid is not null and statusid = 1").order("updated_at DESC").page(params[:page]).per(10)
		else
			@requests = Request.where("userid = #{@user.id} and statusid = 4").order("updated_at DESC").page(params[:page]).per(10)
		end
	end

	def area_for_request
		@areas = get_areas(default_area)
	end

	def update_request_subjects
		#category_id = 1 son las categorías por defecto
		@subjects = RequestTag.where(:area_id => params[:selected_area], :category_id => 1)
		respond_to do |format|
			format.js
		end
	end

	def new_request
		if params[:areaid] != "" && params[:tagid] != ""
			@request = Request.new()
			@user = current_user
			@priorities = RequestPriority.all()
			@area_tags = RequestTag.where(:area_id => params[:areaid], :category_id => 1)
			@selected_tag = RequestTag.find(params[:tagid])
			#temporalmente limitado a enviar solicitudes sólo al área TI
			@area = Area.find(params[:areaid])
		else
			redirect_to :action => :area_for_request
		end
	end

	def add_attachment
		@num = params[:num]
		respond_to do |format|
			format.js
		end
	end

	def edit_request
		@request = Request.find(params[:id])
		@user = current_user
		@priorities = RequestPriority.all()
		@area = Area.find(@request.areaid)
		@area_tags = RequestTag.where(:area_id => @request.areaid)
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
			@user = current_user
			render "edit_request"
		end
	end

	def create_request
		@request = Request.create(request_params)
		if @request.valid?
			tag = RequestTag.find(params[:request][:tagid]).tagname
			#se añade el tag al principio del requerimiento
			@request.subject = tag+" - "+@request.subject
			#Se marca el usuario que envió el requerimiento
			@request.userid = current_user.id
			@request.save!

			#se guardan los adjuntos
			if params[:attachments]
				params[:attachments].each do |att|
					new_attachment = RequestAttachment.new()
					new_attachment.request_id = @request.id
					new_attachment.attached_file = att
					new_attachment.save!
				end
			end

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
			@user = current_user
			@priorities = RequestPriority.all()
			@area = Area.find(@request.areaid)
			@area_tags = RequestTag.where(:area_id => @request.areaid)
			@selected_tag = RequestTag.find(@request.tagid)
			flash[:notice] = "No se pudo registrar la solicitud."
			render "new_request"
		end
	end

	def area_requests
		@area = Area.find(params[:id])
		@active = "all"
		if !@area.nil?
			case params[:f]
			when "assigned"
				#sólo las solicitudes asignadas
				@active = "assigned"
				@requests = Request.where("areaid = #{@area.id} and statusid = 1 and receiverid is not NULL and receiverid <> ''").order("updated_at DESC").page(params[:page]).per(10)
			when "orphaned"
				#solo solicitudes sin asignar
				@active = "orphaned"
				@requests = Request.where(:areaid => @area.id, :statusid => 1, :receiverid => [nil, ""]).order("updated_at DESC").page(params[:page]).per(10)
			else
				#todas las solicitudes
				@requests = Request.where(:areaid => @area.id, :statusid => 1).order("updated_at DESC").page(params[:page]).per(10)
			end
			@receivers = receiver_list(@area.id)
		else
			@requests = nil
		end
	end

	def manage_area_requests
		@area = Area.find(params[:id])
		@active = "manage"
		@tags = RequestTag.where(:area_id => @area.id).order("created_at DESC")
		@default_tag = RequestTag.new()
		@receivers = receiver_list(@area.id)
		@tag_categories = RequestTagCategory.all()
	end

	def create_request_tag
		RequestTag.create(request_tag_params)
		redirect_to :action => :manage_area_requests, :id => params[:request_tag][:area_id]
	end

	def edit_request_tag
		@area = Area.find(params[:id])
		@active = "manage"
		@tags = RequestTag.where(:area_id => @area.id).order("created_at DESC")
		@default_tag = RequestTag.find(params[:tagid])
		@receivers = receiver_list(@area.id)
		@tag_categories = RequestTagCategory.all()
		render :manage_area_requests
	end

	def update_request_tag
		t = RequestTag.find(params[:request_tag][:id])
		t.update_attributes(request_tag_params)
		redirect_to :action => :manage_area_requests, :id => params[:request_tag][:area_id]
	end

	def destroy_request_tag
		RequestTag.find(params[:id]).destroy
		redirect_to :action => :manage_area_requests, :id => params[:area_id]
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

	def delete_request
		change_status(params)
		redirect_to :action => params[:p_action]
	end

	def destroy
		request = Request.find(params[:id])
		if request.userid == current_user.id
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
		return UserV.joins("as user_vs inner join role_assignations
						on role_assignations.userid = user_vs.id
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

		return UserV.joins("as users inner join role_assignations
						on role_assignations.userid = users.id
						and role_assignations.contextid = #{c.id}").select("users.*").order("users.id ASC")
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
	    if current_user.nil?
	      redirect_to :controller => "users", :action => "index"
	    end
	end

	def request_tag_params
		params.require(:request_tag).permit(:tagname, :area_id, :default_user_id)
	end

	def request_params
		params.require(:request).permit(:subject, :tagid, :receiverid, :areaid, :priorityid, :statusid, :duedate, :request, :attach, :pic)
	end

	def notify_user(request_creator,request,new_request)
		request_user = UserV.find(request_creator)
		request_receiver = UserV.find(request.receiverid)
		case request.statusid
		when 1
			if new_request
				subject = "Solicitud Asignada"
				message = "Una solicitud le ha sido asignada. Por favor, revise sus solicitudes."
				NotificationMailer.assigned_request(request_receiver,request).deliver
			else
				subject = "Solicitud Pendiente"
				message = "Una solicitud en espera de confirmación se le ha vuelto a asignar. Por favor, revise sus solicitudes."
				NotificationMailer.reassigned_request(request_receiver,request).deliver
			end
		when 2
			subject = "Solicitud Confirmada"
			message = "Una solicitud con el tema '"+request.subject+"' ha sido confirmada y se ha registrado como resuelta."
			NotificationMailer.confirmed_request(request_receiver,request).deliver
		when 3
			subject = "Solicitud Cancelada"
			message = "Una solicitud con el tema '"+request.subject+"' ha sido cancelada."
			NotificationMailer.canceled_request(request_user,request).deliver
		when 4
			subject = "Solicitud Esperando Confirmación"
			message = "Una solicitud con el tema '"+request.subject+"' ha sido marcada como resuelta y está esperando confirmación. Por favor, revise sus solicitudes enviadas."
			NotificationMailer.waiting_request(request_user,request).deliver
		end
		Notification.create(:userid => request_creator, :subject => subject, :message => message)
	end

	def default_area
		return RequestEnabledArea.all().map{|a| a.area_id}
	end
end
