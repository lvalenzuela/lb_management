module ApplicationHelper
	
	def user_avatar(userid)
		return User.find(userid).avatar.url
	end

	def check_user_alerts(userid)
		alerts = {}
		a = CourseCurrentAlarm.find_by_userid(userid)
		if a.blank?
			alerts[:failing_grades] = 0
			alerts[:failing_attendance] = 0
			alerts[:late_sessions] = 0
			alerts[:offset_content] = 0
		else
			alerts[:failing_grades] = a.courses_failing_grades ? a.courses_failing_grades : 0
			alerts[:failing_attendance] = a.courses_failing_attendance ? a.courses_failing_attendance : 0
			alerts[:late_sessions] = a.courses_late_sessions ? a.courses_late_sessions : 0
			alerts[:offset_content] = a.courses_offset_content ? a.courses_offset_content : 0
		end
		return alerts
	end

	def check_system_alerts
		alerts = {}
		a = CourseCurrentAlarm.find_by_userid(0) #userid = 0 contiene los datos generales
		alerts[:failing_grades] = a.courses_failing_grades
		alerts[:failing_attendance] = a.courses_failing_attendance
		alerts[:late_sessions] = a.courses_late_sessions
		alerts[:offset_content] = a.courses_offset_content
		alerts[:alert_teachers] = a.teachers_low_performance
		return alerts
	end

	def check_user_requests
		userid = current_user.id
		request_data = {}
		wconf = Request.where(:userid => userid, :statusid => 4).count
		if wconf.nil?
			request_data[:req_waiting_conf] = 0
		else
			request_data[:req_waiting_conf] = wconf
		end

		pending = Request.where(:receiverid => userid, :statusid => [1]).count
		if pending.nil?
			request_data[:req_pending] = 0
		else
			request_data[:req_pending] = pending
		end
		return request_data
	end

	def activate_menu_item(desired,active)
		if active.include?(desired)
			return "active"
		end
	end

	def get_notifications(userid)
		Notification.where(:userid => userid).order("id DESC").first(5)
	end

	def seen_notification(seen)
		if seen == 0 #notificacion vista
			"<i class='fa fa-exclamation-circle'></i>"
		else	#notificacion sin ver
			""
		end
	end

	def unseen_notifications(userid)
		n = Notification.where(:userid => userid, :seen => 0)
		if !n.empty? && !n.nil?
			"<i class='fa fa-exclamation'></i>"
		else
			""
		end
	end

	def areas_for_user
		#Areas en que el usuario es manager o administrador
		areas = RoleAssignation.joins("inner join contexts on role_assignations.contextid = contexts.id
										and role_assignations.userid = #{current_user.id}
										and contexts.typeid = 2
										and role_assignations.roleid in (1,2)").select("role_assignations.id,
																				role_assignations.roleid,
																				role_assignations.userid,
																				role_assignations.contextid,
																				contexts.instanceid")
	end

	def get_areaname(areaid)
		Area.find(areaid).areaname
	end
end
