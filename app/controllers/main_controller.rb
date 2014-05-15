class MainController < ApplicationController
  protect_from_forgery
  def index
    if !session[:user_id].nil?
      redirect_to :action => 'control_panel'
    end
  end

  def login
    user = ManagementUser.where(:username => params[:username], :password => Digest::MD5.hexdigest(params[:password]))
    if user.blank?
      flash[:notice] = "Datos incorrectos, por favor vuelve a intentarlo."
      redirect_to :action => 'index'
    else
      session[:user_id] = user.first().id
      session[:username] = user.first().username
      redirect_to :action => 'control_panel'
    end
  end

  def logout
    session.clear
    redirect_to :action => "index"
  end

  def control_panel
    
  end

  def under_construction

  end

  def show
  	@texto = 'hola mundo.'
  	respond_to do |format|
  		format.html
  		format.pdf do
  			pdf = DocumentPdf.new(@texto,view_context)
  			send_data pdf.render,  filename:"test_pdf_document.pdf",
                               type:"application/pdf", 
                               disposition:"inline"
  		end
  	end
  end
end
