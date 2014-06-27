module ApplicationHelper
	

	def activate_menu_item(controller,desired)
		if controller == desired
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

	def is_area_manager(userid)
		requests = RequestArea.where(:area_manager => userid)
		if requests.nil? || requests.empty?
			false
		else
			true
		end
	end

	def areas_for_user
		areas = RequestArea.where(:area_manager => session[:user_id])
	end
end
