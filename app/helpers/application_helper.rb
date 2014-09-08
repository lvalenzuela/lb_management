module ApplicationHelper
	
	def check_user_requests(userid)
		wconf = Request.where("userid = #{userid} and statusid = 4").order("updated_at ASC").count
		if wconf.nil?
			session[:req_waiting_conf] = 0
		else
			session[:req_waiting_conf] = wconf
		end

		pending = Request.where(:receiverid => current_user.id, :statusid => [1]).count
		if pending.nil?
			session[:req_pending] = 0
		else
			session[:req_pending] = pending
		end
		return session[:req_waiting_conf]
	end

	def activate_menu_item(desired,active)
		if active.include?(desired)
			return "active"
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
										and role_assignations.userid = #{current_user.id}
										and contexts.typeid = 2
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
