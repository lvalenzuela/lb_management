class ClientsController < ApplicationController
	before_filter :check_authentication
	protect_from_forgery
	layout "dashboard"

	def index
		@accounts = ContactAccount.joins("inner join contexts as ctx
										on ctx.instanceid = client_accounts.id
										and ctx.typeid = 4")
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
	    if session[:user_id].nil?
	      redirect_to :controller => "users", :action => "index"
	    end
	end

	def get_account_contextid(accountid)
		return Context.where(:typeid => 4, :instanceid => accountid).first().id
	end
end
