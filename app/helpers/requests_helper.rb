module RequestsHelper
	def get_pending_requests()
		query = "select 
					request.id,
					concat(user.firstname, ' ', user.lastname) as solicitante,
					request.subject,
					concat(t_user.firstname, ' ', t_user.lastname) as destinatario,
					r_status.description,
					request.request
				from management_requests as request
				inner join mdl_user as user
					on request.userid = user.id
				inner join mdl_user as t_user
					on request.target_user = t_user.id
				left join management_request_statuses as r_status
					on request.status = r_status.id
				where
					request.target_user is not null
					and request.status = 1"
		ManagementRequest.find_by_sql(query)
	end
end
