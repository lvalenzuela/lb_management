module MoodleCoursesHelper
	def get_template_name(template_id)
		if template_id
			return CourseTemplate.find(template_id).name
		else
			return "-"
		end
	end

	def course_total_sessions(courseid)
		MoodleCourseSessionV.where(:courseid => courseid).count()
	end
end
