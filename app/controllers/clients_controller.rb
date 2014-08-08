class ClientsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"

	def index
		account_list = user_contact_accounts(current_user.id)
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

	def edit
		@contact = Contact.find(params[:id])
		account_list = user_contact_accounts(current_user.id)
		@accounts = ContactAccount.where(:id => account_list)
		@types = ContactType.where("id <> 1")
	end

	def update
		client = Contact.find(params[:contact][:id])
		client.update_attributes(client_params)
		redirect_to :action => "index"
	end

	def new
		@contact = Contact.new()
		account_list = user_contact_accounts(current_user.id)
		@accounts = ContactAccount.where(:id => account_list)
		@types = ContactType.where("id <> 1")
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

	def check_authentication
	    if current_user.nil?
	      redirect_to :controller => "users", :action => "index"
	    end
	end
end
