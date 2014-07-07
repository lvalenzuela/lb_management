class NotificationMailer < ActionMailer::Base
  default from: "no-reply@longbourn.cl"

  def assigned_request(user, request)
  	#Notificación enviada cuando una solicitud ha sido asignada a un usuario
  	@user = user
  	@request = request
  	@url = "http://summit.longbourn.cl/requests"
  	mail(to: @user.email, subject: "Longbourn Summit: Una solicitud le ha sido asignada.")
  end

  def reassigned_request(user,request)
  	@user = user
  	@request = request
  	@url = "http://summit.longbourn.cl/requests"
  	mail(to: @user.email, subject: "Longbourn Summit: Una solicitud le ha sido asignada.")
  end

  def canceled_request(user, request)
  	#Notificacion enviada cuando una solicitud asignada a un usuario ha sido cancelada
  	@user = user
  	@request = request
  	@url = "http://summit.longbourn.cl/requests"
  	mail(to: @user.email, subject: "Longbourn Summit: Una de sus solicitudes ha sido cancelada.")
  end

  def confirmed_request(user, request)
  	#Notificacion enviada cuando una solicitud asignada a un usuario ha sido aprovada
  	@user = user
  	@request = request
  	@url = "http://summit.longbourn.cl/requests"
  	mail(to: @user.email, subject: "Longbourn Summit: Su resolución ha sido aceptada.")
  end

  def waiting_request(user, request)
  	#Notificacion enviada cuando una solicitud realizada por un usuario requere de su confirmación
  	@user = user
  	@request = request
  	@url = "http://summit.longbourn.cl"
  	mail(to: @user.email, subject: "Longbourn Summit: Una de sus solicitudes espera confirmación.")
  end
end
