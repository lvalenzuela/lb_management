class NotificationMailer < ActionMailer::Base
  default from: "no-reply@longbourn.cl"

  def request_for_area(receiver_user,request)
  	@user = receiver_user
  	@request = request
  	@area = Area.find(request.areaid)
  	@url = "http://summit.longbourn.cl/requests/area_requests?id="+request.areaid.to_s
  	mail(to: @user.email, subject: "Longbourn Summit: Nueva solicitud realizada a su área.")
  end

  def assigned_request(receiver_user, request)
  	#Notificación enviada cuando una solicitud ha sido asignada a un usuario
  	@user = receiver_user
  	@request = request
  	@url = "http://summit.longbourn.cl/requests"
  	mail(to: @user.email, subject: "Longbourn Summit: Una solicitud le ha sido asignada.")
  end

  def reassigned_request(receiver_user,request)
  	@user = receiver_user
  	@request = request
  	@url = "http://summit.longbourn.cl/requests"
  	mail(to: @user.email, subject: "Longbourn Summit: Una solicitud le ha sido asignada.")
  end

  def canceled_request(receiver_user, request)
  	#Notificacion enviada cuando una solicitud asignada a un usuario ha sido cancelada
  	@user = receiver_user
  	@request = request
  	@url = "http://summit.longbourn.cl/requests"
  	mail(to: @user.email, subject: "Longbourn Summit: Una de sus solicitudes ha sido cancelada.")
  end

  def confirmed_request(receiver_user, request)
  	#Notificacion enviada cuando una solicitud asignada a un usuario ha sido aprovada
  	@user = receiver_user
  	@request = request
  	@url = "http://summit.longbourn.cl/requests"
  	mail(to: @user.email, subject: "Longbourn Summit: Su resolución ha sido aceptada.")
  end

  def waiting_request(receiver_user, request)
  	#Notificacion enviada cuando una solicitud realizada por un usuario requere de su confirmación
  	@user = receiver_user
  	@request = request
  	@url = "http://summit.longbourn.cl"
  	mail(to: @user.email, subject: "Longbourn Summit: Una de sus solicitudes espera confirmación.")
  end

  def new_forum_msg(receiver_user,request)
  	@user = receiver_user
  	@request = request
  	@url = "http://summit.longbourn.cl/request_notes/show?id="+request.id.to_s
  	mail(to: @user.email, subject: "Longbourn Summit: Hay un nuevo mensaje en una de sus solicitudes.")
  end
end
