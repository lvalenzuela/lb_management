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

	def get_request(id)
		query = "select 
					request.id,
					concat(user.firstname, ' ', user.lastname) as solicitante,
					request.subject,
					concat(t_user.firstname, ' ', t_user.lastname) as destinatario,
					r_priority.id as priority_id,
					r_priority.shortname as p_shortname,
					r_status.description,
					request.request
				from management_requests as request
				inner join mdl_user as user
					on request.userid = user.id
				inner join mdl_user as t_user
					on request.target_user = t_user.id
				left join management_request_statuses as r_status
					on request.status = r_status.id
				inner join management_request_priorities as r_priority
					on request.priority = r_priority.id
				where
					request.id = #{id}"
		ManagementRequest.find_by_sql(query).first()
	end

	def requests_for_user(t_areas, status_values, priority_values)
		
		if !t_areas.nil?
			areas = "request.target_area in ("
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


		if !t_areas.nil? || !status_values.nil? || !priority_values.nil?
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
						on request.target_area = area.id
					left join management_request_statuses as r_status
						on request.status = r_status.id
					inner join management_request_priorities as r_priority
						on request.priority = r_priority.id
					where
						#{areas}
						#{statuses}
						#{priorities}
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
						on request.target_area = area.id
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
