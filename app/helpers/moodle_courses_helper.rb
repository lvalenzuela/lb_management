module MoodleCoursesHelper
	def get_template_name(template_id)
		if template_id
			return CourseTemplate.find(template_id).name
		else
			return "-"
		end
	end
end
