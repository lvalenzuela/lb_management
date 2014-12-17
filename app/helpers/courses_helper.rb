module CoursesHelper

	def alert_row_class(status)
		case status
		when 1 #pendiente
			return "danger"
		when 2
			return "success"
		else
			return "warning"
		end
	end

	def course_init_tasks(courseid)
		return CourseInitTask.where(:course_id => courseid).map{|t| t.request_id}
	end

	def complete_init_tasks(courseid)
		requests = course_init_tasks(courseid)
		return Request.where(:id => requests, :statusid => 2).count
	end

	def count_course_init_tasks(courseid)
		return CourseInitTask.where(:course_id => courseid).count
	end

	def classroom_name(classroom_id)
		if classroom_id
			return Classroom.find(classroom_id).name
		else
			return ""
		end
	end

	def location_label(location_id)
		if location_id
			return Location.find(location_id).name
		else
			return ""
		end
	end

	def simulation(simulated,teacherid)
		if simulated && simulated.id == teacherid
			return true
		else
			return false
		end
	end

	def get_course_mode_label(mode)
		return CourseMode.find(mode).mode_name
	end

	def teacher_level_label(teacher_level_id)
		if teacher_level_id
			return UserTeacherLevel.find(teacher_level_id).level_label
		else
			return "-"
		end
	end

	def course_feature_value(features,f_name)
		return features.find_by_feature_name(f_name).feature_description
	end

	def get_session_type(session_type_id)
		if session_type_id
			return CourseSessionType.find(session_type_id).type_name
		else
			return ""
		end
	end

	def get_course_level(level_id)
		if level_id
			return CourseLevel.find(level_id).course_level
		else
			return ""
		end
	end

	def get_course_type(id)
		return CourseType.find(id).typename
	end

	def weekday_options
		return [["Lunes",1],
				["Martes",2],
				["Miercoles",3],
				["Jueves",4],
				["Viernes",5],
				["Sabado",6]]
	end

	def get_course_status(statusid)
		return CourseStatus.find(statusid).statusname
	end

	def get_user_name(user_id)
		if user_id
			user = UserV.find(user_id)
			return user.name
		else
			return "-"
		end
	end
	
	def get_course_feature(course_features, desired)
		feature = course_features.where(:feature_name => desired)
		if feature.nil?
			return ""
		else
			return feature.first().feature_description
		end
	end
end
