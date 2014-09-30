module DashboardHelper

	def inclass_attitude(attitude)
		case attitude
		when 1
			return "Buena"
		when 2
			return "Mala"
		else
			return "No Registrada"
		end			
	end

	def inclass_work(work)
		case work
		when 1
			return "Malo"
		when 2
			return "Insuficiente"
		when 3
			return "Regular"
		when 4
			return "Bueno"
		when 5
			return "Excelente"
		else
			return "No Registrado"
		end			
	end

	def translate_attendance_acronym(acronym)
		case acronym
		when 'P'
			return "<span class='label label-success'>Presente</span>"
		else
			return "<span class='label label-danger'>Ausente</span>"
		end
	end

	def template_name(template_id)
		if template_id
			return CourseTemplate.find(template_id).name
		else
			return ""
		end
	end

	def min_attendance()
		return CourseAlarmParameter.where(:param_name => "min_attendance").first().value
	end

	def taken_session_content(index,array)
		if array[index-1]
			return array[index-1]
		else
			return "-"
		end
	end

	def user_name(userid)
		user = UserV.where(:id => userid).first()
		if user.blank?
			return "-"
		else
			return user.name
		end
	end

	def user_mail(userid)
		user = UserV.where(:id => userid).first()
		if user.blank?
			return "-"
		else
			return user.email
		end
	end

	def student_name(userid)
		student = UserReport.where(:userid => userid).first()
		if student.blank?
			return ""
		else
			return student.firstname+" "+student.lastname
		end
	end

	def moodle_course_name(courseid)
		return MoodleCourseV.find_by_moodleid(courseid).coursename
	end

	def attendance_pct(student_info)
		return (student_info.present_sessions.to_f*100/(student_info.present_sessions + student_info.absent_sessions)).round(1)
	end

	def failing_grades_students(course)
		#Todas las notas de los alumnos del curso seleccionado
		students_grades = StudentGradesReport.where("courseid = #{course.courseid} and created_at = '#{course.created_at}' and categoryname = '?' and itemname is null and finalgrade is not null")
		min_grade = CourseAlarmParameter.where(:param_name => "approve_grade").first().value
		min_grade = grade_to_points(min_grade)
		total_students = students_grades.distinct.count(:userid)
		failing_students = students_grades.where("finalgrade < #{min_grade}").distinct.count(:userid)
		return failing_students.to_s+" / "+total_students.to_s
	end

	def failing_attendance_students(course)
		students_attendance = StudentGeneralAttendanceReport.where(:courseid => course.courseid, :created_at => course.created_at)
		min_attendance = CourseAlarmParameter.where(:param_name => "min_attendance").first().value.to_i
		total_students = students_attendance.distinct.count(:userid)
		failing_students = students_attendance.where("(present_sessions*100/(present_sessions+absent_sessions)) < #{min_attendance}").distinct.count(:userid)		
		return failing_students.to_s+" / "+total_students.to_s
	end

	def sessions_taken_badge(course)
		if course.current_booked_sessions.nil?
			return "bg-red"
		else
			if course.current_booked_sessions > course.current_taken_sessions
				return "bg-yellow"
			else
				return "bg-light-blue"
			end
		end
	end

	def grade_badge_class(grade, gradetype)
		case gradetype.to_i
		when 2
			if grade.nil?
				return "bg-red"
			else
				min_grade = CourseAlarmParameter.where(:param_name => "approve_grade").first().value
				min_grade = grade_to_points(min_grade)
				if grade < min_grade
					return "bg-red"
				else
					return "bg-light-blue"
				end
			end
		else
			return "bg-yellow"
		end
	end

	def course_current_progress_bar(course)
		if !course.current_booked_sessions.nil? && !course.current_taken_sessions.nil?
			color = course.current_booked_sessions - course.current_taken_sessions
		else
			color = nil
		end

		max_attendance_delay = CourseAlarmParameter.find_by_param_name("max_attendance_delay")

		case color
		when 0
			return "progress-bar progress-bar-success"
		when 1..max_attendance_delay.value.to_i
			return "progress-bar progress-bar-warning" 
		else
			return "progress-bar progress-bar-danger"
		end
	end

	def progress_bar_pct(progress,total)
		if total != 0 and !total.nil?
			pct = (progress*100/total).round(0)
		else
			pct = 0
		end

		return pct.to_s+"%"
	end

	def dashboard_grade_parser(grade, gradetype)
		case gradetype
		when 1
			if grade.nil?
				return "-"
			else
				return grade.round(1).to_s+"%"
			end
		when 2
			#transforma notas desde una escala de 0 a 61 a la escala chilena
			scale = ['1.0','1.1','1.2','1.3','1.4','1.5','1.6','1.7','1.8','1.9','2.0','2.1','2.2','2.3','2.4','2.5','2.6','2.7','2.8','2.9','3.0','3.1','3.2','3.3','3.4','3.5','3.6','3.7','3.8','3.9','4.0','4.1','4.2','4.3','4.4','4.5','4.6','4.7','4.8','4.9','5.0','5.1','5.2','5.3','5.4','5.5','5.6','5.7','5.8','5.9','6.0','6.1','6.2','6.3','6.4','6.5','6.6','6.7','6.8','6.9','7.0']
			if grade.nil?
				return "-"
			else
				grade = grade.round(0)
				return scale[grade-1]
			end
		else
			return gradetype
		end
	end

	def grade_to_points(grade)
		grade_array = grade.split(".")
		return (grade[0].to_i - 1) * 10 + grade[1].to_i + 1
	end
end
