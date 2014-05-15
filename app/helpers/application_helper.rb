module ApplicationHelper
	def highlight_menu_item(controller,desired)
		if controller == desired
			return "active"
		end

	end
end
