module MainHelper

	def get_rolename(roleid)
		Role.find(roleid).rolename
	end
end
