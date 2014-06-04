module ApplicationHelper
	def highlight_menu_item(controller,desired)
		if controller == desired
			return "active"
		end
	end

	def get_notifications(userid)
		ManagementNotification.all().order("created_at DESC").first(5)
	end

	def read_notifications(id)
		notification = ManagementNotification.find(id)

		if notification.read == 0
			"style='background-color: #0075b0;'".html_safe
		else
			"style =''"
		end
	end
end
