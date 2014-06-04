module RequestsHelper

	def get_priority_list
		ManagementRequestPriority.all()
	end

	def get_status_list
		ManagementRequestStatus.all()
	end

	def get_area_list
		ManagementRequestArea.all()
	end

	def get_receiver_list(area_id)
		area = ManagementRequestArea.find(area_id)
		receiverlist = User.where(:institution => "Longbourn Institute", :department => area.area_name) 
	end

	def request_areaname(receiverarea)
		ManagementRequestArea.find(receiverarea).area_name
	end

	def request_priority_desc(priority)
		ManagementRequestPriority.find(priority).shortname
	end

	def request_status_desc(status)
		ManagementRequestStatus.find(status).description
	end

	def get_username(userid)
		user = User.find(userid)

		username = user.firstname+" "+user.lastname
	end

	def requests_list(t_areas,status_values,priority_values,userid)
		
		if !t_areas.nil?
			areas = "request.receiverarea in ("
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
				statuses = "and request.status in ("
			else
				statuses = "request.status in ("
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
				priorities = "and request.priority in ("
			else
				priorities = "request.priority in ("
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
				user_str = "and request.userid = "+userid.to_s
			else
				user_str = "request.userid = "+userid.to_s
			end
		else
			user_str = ""
		end


		if !t_areas.nil? || !status_values.nil? || !priority_values.nil? || !userid.nil?
			query = "select 
						request.*,
						concat(user.firstname, ' ', user.lastname) as solicitante,
						area.id as t_areaid,
						area.area_name as t_areaname,
						r_priority.id as priority_id,
						r_priority.shortname as p_shortname,
						r_status.description
					from management_requests as request
					inner join mdl_user as user
						on request.userid = user.id
					inner join management_request_areas as area
						on request.receiverarea = area.id
					left join management_request_statuses as r_status
						on request.status = r_status.id
					inner join management_request_priorities as r_priority
						on request.priority = r_priority.id
					where
						#{areas}
						#{statuses}
						#{priorities}
						#{user_str}
					order by priority_id ASC"

		else #todas las solicitudes
			query = "select 
						request.*,
						concat(user.firstname, ' ', user.lastname) as solicitante,
						area.id as t_areaid,
						area.area_name as t_areaname,
						r_priority.id as priority_id,
						r_priority.shortname as p_shortname,
						r_status.description
					from management_requests as request
					inner join mdl_user as user
						on request.userid = user.id
					inner join management_request_areas as area
						on request.receiverarea = area.id
					left join management_request_statuses as r_status
						on request.status = r_status.id
					inner join management_request_priorities as r_priority
						on request.priority = r_priority.id
					order by priority_id ASC"
		end
						
		ManagementRequest.find_by_sql(query)
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
