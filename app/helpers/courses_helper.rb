module CoursesHelper

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
		return [["Lunes","Lunes"],
				["Martes","Martes"],
				["Miercoles","Miercoles"],
				["Jueves","Jueves"],
				["Viernes","Viernes"],
				["Sabado","Sabado"]]
	end

	def get_course_status(statusid)
		return CourseStatus.find(statusid).statusname
	end

	def get_user_name(user_id)
		if user_id
			user = User.find(user_id)
			return user.firstname+" "+user.lastname
		else
			return ""
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
