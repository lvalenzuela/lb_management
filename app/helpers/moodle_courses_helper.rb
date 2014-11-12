module MoodleCoursesHelper

	def check_if_sence(sence)
		if sence.nil? || sence == ""
			return "<i class='fa fa-times fa-lg'></i>"
		else
			return "<i class='fa fa-check fa-lg'></i>"
		end		
	end

	def get_template_name(template_id)
		if template_id
			return CourseTemplate.find(template_id).name
		else
			return "-"
		end
	end

	def course_total_sessions(courseid)
		return MoodleCourseSessionV.where(:courseid => courseid).count()
	end
end
