class ClientsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"

	def index
		account_list = user_contact_accounts(session[:user_id])
		#Cuentas de clientes correspondientes al usuario
		@accounts = ContactAccount.where(:id => account_list)
		if params[:accountid]
			@clients = Contact.where(:accountid => params[:accountid])
			@selected = ContactAccount.find(params[:accountid])
		else
			@clients = {}
			@selected = {}
		end
	end

	def new
		@contact = Contact.new()
		account_list = user_contact_accounts(session[:user_id])
		@accounts = ContactAccount.where(:id => account_list)
		@types = ContactType.all()
	end

	def create
		@client = Contact.create(client_params)
		if @client.valid?
			#cliente creado con éxito
			#mostrar listado de clientes 
			redirect_to :action => "index"
		else
			#no se pudo crear el cliente
			render :action => "new"
		end
	end

	def quotations
		@user_quotations = Quotation.where(:userid => session[:user_id])
		account_list = user_contact_accounts(session[:user_id])
		@clients = Contact.where(:accountid => account_list)
	end

	def new_quotation
		#longbourn institute
		@provider = Contact.where(:typeid => 1).first()
		@user = User.find(session[:user_id])
		@client = Contact.find(params[:clientid])
		@quotation = Quotation.new()
		t = QuotationTemplate.where(:userid => session[:user_id], :default => 1).first()
		if t.nil? || t.blank?
			@template = nil
		end

	end

	def manage_quotations
		@defaults = QuotationTemplate.where(:userid => [0,session[:user_id]])
	end

	def create_quotation_format
		if params[:quotation_template][:default] == 1
			#verificar si hay algun otro template marcado como default...
			#si lo hay, eliminarlo
		end
		QuotationTemplate.create(quotation_format_params)
		redirect_to :action => "manage_quotations"
	end

	def set_default_format
		d = QuotationTemplate.where(:userid => session[:user_id], :default => 1).first()
		if d.nil? || d.blank?
			#no hay un formato establecido por defecto
			#no se hace nada
		else
			if d.id == params[:id]
				#El formato ya esta asignado como formato por defecto
				redirect_to :action => "create_quotation_format"
			else
				#El formato encontrado deja de ser el formato por defecto
				d.update_attributes(:default => 0)
			end
		end
		#se establece el formato seleccionado como el formato por defecto
		qd = QuotationTemplate.find(params[:id])
		qd.update_attributes(:default => 1)
		redirect_to :action => "create_quotation_format"
	end

	def manage_accounts
		@accounts = ContactAccount.all()
	end

	def create_account
		if params[:accountname] && params[:description]
			flash[:notice] = "Cuenta creada con éxito."
			last_account = ContactAccount.create(params.permit(:accountname,:description))
			#al crear una nueva cuenta, registrarlo tambien en la tabla de contexto
			Context.create(:typeid => 4, :instanceid => last_account.id)
		else
			flash[:notice] = "No se pudo crear la cuenta."
		end
		redirect_to :action => "manage_accounts"
	end

	def show_account
		@account = ContactAccount.find(params[:id])
		@account_clients = Contact.where(:accountid => params[:id])
		@system_clients = Contact.where("accountid <> #{params[:id]}")
		account_context = get_account_contextid(@account.id)
		@account_managers = User.joins("inner join role_assignations as ra
										on users.id = ra.userid
										and ra.contextid = #{account_context}
										and ra.roleid in (1,2)")
	end

	def account_managers
		@account = ContactAccount.find(params[:id])
		account_context = get_account_contextid(@account.id)
		@account_managers = User.joins("inner join role_assignations as ra
										on users.id = ra.userid
										and ra.contextid = #{account_context}
										and ra.roleid in (1,2)")
		managers_list = []
		@account_managers.each do |a|
			managers_list << a.id
		end
		if managers_list.empty?
			@system_users = User.all()
		else
			@system_users = User.where("id not in (?)", managers_list)
		end
	end

	def modify_account_managers
		account_context = get_account_contextid(params[:accountid])
		case params[:opt]
		when "rmv"
			#Se elimina la asociación del usuario con la instancia
			RoleAssignation.where(:contextid => account_context, :userid => params[:userid]).destroy_all
		when "add"
			#Se registra al usuario como manager de la instancia
			RoleAssignation.create(:contextid => account_context, :userid => params[:userid], :roleid => 2)
		end
		redirect_to :action => "account_managers", :id => params[:accountid]
	end

	def assign_client
		if params[:clients]
			params[:clients].each do |c|
				client = Contact.find(c)
				client.update_attributes(:accountid => params[:accountid])
			end
		end
	end

	private

	def client_params
		params.require(:contact).permit(:firstname, :lastname, :rut, :institution, :email, :phone, :accountid, :typeid, :statusid, :address)
	end

	def quotation_format_params
		params.require(:quotation_template).permit(:title, :body, :footer, :userid, :default)
	end

	def check_authentication
	    if session[:user_id].nil?
	      redirect_to :controller => "users", :action => "index"
	    end
	end

	def get_account_contextid(accountid)
		return Context.where(:typeid => 4, :instanceid => accountid).first().id
	end

	def user_contact_accounts(userid)
		#Obtiene las instancias de los contextos en los que
		#el usuario esta asignado y es administrador
		context = Context.joins("inner join role_assignations as ra
							on contexts.id = ra.contextid
							and contexts.typeid = 4
							and ra.userid = #{userid}")
		user_account_list = []
		context.each do |c|
			user_account_list << c.instanceid
		end
		return user_account_list
	end
end
