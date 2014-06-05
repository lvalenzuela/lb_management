module RequestsHelper

	def get_priority_list
		RequestPriority.all()
	end

	def get_status_list
		RequestStatus.all()
	end

	def get_area_list
		RequestArea.all()
	end

	def get_receiver_list(area_id)
		area = RequestArea.find(area_id)
		receiverlist = User.where(:institution => "Longbourn Institute", :department => area.areaname) 
	end

	def request_areaname(receiverarea)
		RequestArea.find(receiverarea).areaname
	end

	def request_priority_desc(priority)
		RequestPriority.find(priority).description
	end

	def request_status_desc(status)
		RequestStatus.find(status).description
	end

	def get_username(userid)
		user = User.find(userid)

		username = user.firstname+" "+user.lastname
	end

	def requests_list(t_areas,status_values,priority_values,userid)
		
		if !t_areas.nil?
			areas = "areaid in ("
			t_areas.each do |a|
				if a != t_areas.last
					areas = areas + a.to_s + ","
				else
					areas = areas + a.to_s + ")"
				end
			end
		else
			areas = ""
		end

		if !status_values.nil?
			if !t_areas.nil?
				statuses = "and statusid in ("
			else
				statuses = "statusid in ("
			end
			status_values.each do |s|
				if s != status_values.last
					statuses = statuses + s.to_s + ","
				else
					statuses = statuses + s.to_s + ")"
				end
			end
		else
			statuses = ""
		end

		if !priority_values.nil?
			if !t_areas.nil? || !status_values.nil?
				priorities = "and priorityid in ("
			else
				priorities = "priorityid in ("
			end
			priority_values.each do |p|
				if p != priority_values.last
					priorities = priorities + p.to_s + ","
				else
					priorities = priorities + p.to_s + ")"
				end
			end
		else
			priorities = ""
		end

		if !userid.nil?
			if !t_areas.nil? || !status_values.nil? || !priority_values.nil?
				user_str = "and userid = "+userid.to_s
			else
				user_str = "userid = "+userid.to_s
			end
		else
			user_str = ""
		end


		if !t_areas.nil? || !status_values.nil? || !priority_values.nil? || !userid.nil?
			Request.where("#{areas} #{statuses} #{priorities} #{user_str}").order("priorityid ASC")
		else #todas las solicitudes
			Request.all().order("priorityid ASC")
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
