module ApplicationHelper
	def highlight_menu_item(controller,desired)
		if controller == desired
			return "active"
		end
	end

	def get_notifications(userid)
		Notification.all().order("created_at DESC").first(5)
	end

	def seen_notifications(id)
		notification = Notification.find(id)

		if notification.seen == 0
			"style='background-color: #0075b0;'".html_safe
		else
			"style =''"
		end
	end
end
