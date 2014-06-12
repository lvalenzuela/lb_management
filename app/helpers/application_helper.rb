module ApplicationHelper
	def highlight_menu_item(controller,desired)
		if controller == desired
			return "active"
		end
	end

	def get_notifications(userid)
		Notification.where(:userid => userid).order("id DESC").first(5)
	end

	def seen_notifications(id)
		notification = Notification.find(id)

		if notification.seen == 0
			"style='background-color: #C0C0C0;'".html_safe
		else
			"style =''"
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
