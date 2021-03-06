module MainHelper

	def active_area(area_id)
		enabled = RequestEnabledArea.find_by_area_id(area_id)
		if enabled.blank?
			return false
		else
			return true
		end
	end

	def teacher_level_label(teacher_level)
		if teacher_level
			return TeacherLevel.find(teacher_level).level_label
		else
			return "-"
		end
	end

	def print_classroom_matching(matching_array)
		array = matching_array.split(",")
		printing = ""
		array.each do |a|
			slot = ClassroomAvailability.find(a.to_i)
			printing = printing+"#{week_day(slot.weekday)} - #{l(slot.start_hour, :format => '%H:%M')} - Sala: #{Classroom.find(slot.classroom_id).name}"
			if a != array.last
				printing = printing+" || "
			end
		end
		return printing
	end

	def check_disponibility(disponibility, day)
		disp = disponibility.select{|d| d.day_number == day}.first()

		if disp.blank?
			return false
		elsif disp.start_time.nil?
			return false
		else
			return true
		end
	end

	def check_extra_time(disponibility, day)
		extra_time = disponibility.select{|d| d.day_number == day}.first()
		if extra_time.blank?
			#si no hay nada registrado para el dia
			return false
		elsif extra_time.extra_start_time.nil?
			#si hay registros para el dia, pero no horarios extra
			return false
		else
			return true
		end

	end

	def append_with_comma(item1,item2)
		if item1
			return item1+","+item2
		else
			return ","+item2
		end
	end

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
		raw_courses = MoodleRoleAssignationV.where(:userid => teacherid, :roleid => [4,9]).group(:courseid).map{|rc| rc.courseid}
		return DashboardCoursesV.where(:courseid => raw_courses, :visible => 1).count(:courseid)
		
		#otra forma de conteo
		#return MoodleRoleAssignationV.joins("as mra inner join moodle_course_vs as courses
		#									on mra.courseid = courses.moodleid").where("
		#									courses.visible = 1 and mra.userid = #{teacherid} and mra.roleid in (9,4)").count()
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
