module RequestsHelper

	def request_tag_category_name(category_id)
		return RequestTagCategory.find(category_id).name
	end

	def days_left(r_date)
		if r_date
			d_left = (r_date - Date.today).to_i
			if d_left < 0
				return 0
			else
				return d_left
			end
		else
			return 0
		end
	end

	def is_editable(request)
		if request.userid == current_user.id
			if request.statusid != 2 && request.statusid != 3
				return true
			else
				return false
			end
		else
			return false
		end
	end

	def request_display_mode(request)
		if has_unseen_messages(request.last_msg_datetime, request, current_user.id)
			return "unread"
		else
			return "read"
		end
	end

	def req_priority_label(priorityid)
		case priorityid
		when 1
			return "bg-red"
		when 2
			return "bg-yellow"
		when 3
			return "bg-blue"
		else
			return "bg-green"
		end
	end

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
			return RequestTag.find(id).tagname
		else
			return "-"
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
			""
		else
			user = UserV.find(userid)
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
