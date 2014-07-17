module RequestsHelper

	def activate_tab(current,desired)
		if current.include?(desired)
			return "class=active"
		end
	end

	def has_unseen_messages(last_msg_time,request,user)
		if last_msg_time.nil?
			return false 
		else
			last_check = LastRequestMessageCheck.where(:requestid => request, :userid => user).first()
			if last_check.nil?
				return true
			else
				if last_msg_time > last_check.last_check_datetime
					return true
				else
					return false
				end
			end
		end
	end

	def get_tagname(id)
		if !id.nil?
			tagname = Tag.find(id).tagname
		else
			"-"
		end
	end

	def display_sent_requests
		if action_name == "sent_requests"
			"display: block;"
		else
			"display: none;"
		end
	end

	def show_date(date)
		if !date.nil? && date != ""
			date.strftime("%d-%m-%Y")
		else
			""
		end
	end

	def request_areaname(receiverarea)
		Area.find(receiverarea).areaname
	end

	def request_priority_desc(priority)
		RequestPriority.find(priority).description
	end

	def request_status_desc(status)
		RequestStatus.find(status).description
	end

	def get_username(userid)
		if userid.nil?
			nil
		else
			user = User.find(userid)
			username = user.firstname+" "+user.lastname
		end
	end

	def priority_class(priority)
		case priority
		when 1 #urgente
			return "class=danger"
		when 2 #importante
			return "class=warning"
		when 3 #normal
			return "class=info"
		when 4 #poco importante
			return ""
		else
			return ""
		end
	end
end
