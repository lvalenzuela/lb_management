module MainHelper

	def get_rolename(roleid)
		Role.find(roleid).rolename
	end

	def activate_tab(current, desired)
		if current.include?(desired)
			return "class=active"
		end
	end
end
