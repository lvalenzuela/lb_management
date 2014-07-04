module ApplicationHelper
	

	def activate_menu_item(controller,desired)
		if desired.include?(controller)
			return "class=active"
		end
	end

	def get_notifications(userid)
		Notification.where(:userid => userid).order("id DESC").first(5)
	end

	def seen_notification(seen)
		if seen == 0 #notificacion vista
			"<i class='fa fa-exclamation-circle'></i>"
		else	#notificacion sin ver
			""
		end
	end

	def unseen_notifications(userid)
		n = Notification.where(:userid => userid, :seen => 0)
		if !n.empty? && !n.nil?
			"<i class='fa fa-exclamation'></i>"
		else
			""
		end
	end

	def areas_for_user
		#Areas en que el usuario es manager o administrador
		areas = RoleAssignation.joins("inner join contexts on role_assignations.contextid = contexts.id
										and role_assignations.userid = #{session[:user_id]}
										and contexts.descriptionid = 2
										and role_assignations.roleid in (1,2)").select("role_assignations.id,
																				role_assignations.roleid,
																				role_assignations.userid,
																				role_assignations.contextid,
																				contexts.instanceid")
	end

	def get_areaname(areaid)
		Area.find(areaid).areaname
	end
end
