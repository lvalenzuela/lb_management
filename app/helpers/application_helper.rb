module ApplicationHelper
	
	def user_avatar(userid)
		return User.find(userid).avatar.url
	end

	def check_user_alerts(userid)
		alerts = {}
		#nota minima de aprobacion
		min_grade = CourseAlarmParameter.where(:param_name => "approve_grade").first().value
		min_grade = grade_to_points(min_grade)
		#porcentaje mínimo de asistencia
		min_attendance = CourseAlarmParameter.where(:param_name => "min_attendance").first().value.to_i
		#maximo atraso en clases
		max_delay = CourseAlarmParameter.where(:param_name => "max_attendance_delay").first().value.to_i
		f_grades = DashboardCoursesV.where("mean_grade < #{min_grade} and visible = 1 and gradetype = 2")
		f_attendance = DashboardCoursesV.where("(avg_attendance_ratio*100) < #{min_attendance} and visible = 1")
		f_late = DashboardCoursesV.where("(current_booked_sessions - current_taken_sessions) > #{max_delay} and visible = 1")

		courses = []
		courses.push(f_grades.map{|c| c.courseid})
		courses.push(f_attendance.where.not(:courseid => courses).map{|c| c.courseid})
		courses.push(f_late.where.not(:courseid => courses).map{|c| c.courseid})
		available_teachers = TeacherV.all().map{|t| t.id}

		f_teachers = MoodleRoleAssignationV.where("courseid in (?) and roleid in (9,4) and userid in (?)",courses.flatten, available_teachers.flatten)

		alerts[:failing_grades] = f_grades.distinct.count(:courseid)
		alerts[:failing_attendance] = f_attendance.distinct.count(:courseid)
		alerts[:late_sessions] = f_late.distinct.count(:courseid)
		alerts[:alert_teachers] = f_teachers.distinct.count(:userid)
		return alerts
	end

	def check_user_requests(userid)
		wconf = Request.where("userid = #{userid} and statusid = 4").order("updated_at ASC").count
		if wconf.nil?
			session[:req_waiting_conf] = 0
		else
			session[:req_waiting_conf] = wconf
		end

		pending = Request.where(:receiverid => current_user.id, :statusid => [1]).count
		if pending.nil?
			session[:req_pending] = 0
		else
			session[:req_pending] = pending
		end
		return session[:req_waiting_conf]
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
