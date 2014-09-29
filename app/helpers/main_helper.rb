module MainHelper

	def week_day(day_number)
		case day_number
		when 1
			return "Lunes"
		when 2
			return "Martes"
		when 3
			return "Miércoles"
		when 4
			return "Jueves"
		when 5
			return "Viernes"
		when 6
			return "Sábado"
		else
			return "Domingo"
		end
	end

	def teacher_courses_count(teacherid)
		return MoodleRoleAssignationV.joins("as mra inner join moodle_course_vs as courses
											on mra.courseid = courses.moodleid").where("
											courses.visible = 1 and mra.userid = #{teacherid}").count()
	end

	def get_rolename(roleid)
		Role.find(roleid).rolename
	end

	def activate_tab(current, desired)
		if current.include?(desired)
			return "class=active"
		end
	end
end
