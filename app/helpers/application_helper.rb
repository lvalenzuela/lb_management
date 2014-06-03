module ApplicationHelper
	def highlight_menu_item(controller,desired)
		if controller == desired
			return "active"
		end
	end

	def get_notifications(userid)
		ManagementNotification.all().first(5)
	end
end
