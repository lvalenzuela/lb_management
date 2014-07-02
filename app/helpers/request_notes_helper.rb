module RequestNotesHelper

	def get_username(userid)
		u = User.find(userid)
		return u.firstname+" "+u.lastname
	end
end
