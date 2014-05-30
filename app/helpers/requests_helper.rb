module RequestsHelper
	def get_pending_requests()
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
					request.target_user is not null
					and request.status = 1
				order by priority_id ASC"
		ManagementRequest.find_by_sql(query)
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
