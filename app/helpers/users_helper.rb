module UsersHelper
	def get_rolename(roleid)
		return Role.find(roleid).rolename
	end

	def get_area_name_by_context(contextid)
		c = Context.find(contextid)
		return Area.find(c.instanceid).areaname
	end
end
