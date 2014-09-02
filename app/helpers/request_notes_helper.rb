module RequestNotesHelper

	def get_username(userid)
		u = User.find(userid)
		return u.firstname+" "+u.lastname
	end

	def request_status_desc(status)
		return RequestStatus.find(status).description
	end

	def request_display_status(status)
		case status
		when 1
			return "alert-default"
		when 2
			return "alert-success"
		when 3
			return "alert-danger"
		else
			return "alert-warning"
		end
	end
end
