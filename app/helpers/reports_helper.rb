module ReportsHelper

	def activate_tab(current,desired)
		if current.include?(desired)
			return "class=active"
		end
	end

	def get_groupname(groupid)
		return MoodleGroup.find(groupid).groupname
	end

	def get_client_list(institution)
		if institution.nil?
			@clients = UserReport.select("institution, 
										count(distinct department) as departments, 
										count(distinct courseid) as courses, 
										count(distinct userid) as users").where("institution <> '' and institution is not null").group(:institution)
		else
			@clients = UserReport.select("institution, 
										count(distinct department) as departments, 
										count(distinct courseid) as courses, 
										count(distinct userid) as users").where("institution like '%#{institution}%'").group(:institution)
		end
	end

	def find_course_by_institution(institution,filter)
		if filter.to_i == 1 || filter.nil?
			@groups = UserReport.select("
							distinct(courseid), 
							coursename as fullname,
							institution,
							count(distinct userid) as alumnos,
							count(distinct department) as departments").where("
							lower(institution) = lower('#{institution}') and
							coursename is not null and
							coursename <> '' and
							created_at = (select max(created_at) from user_reports)").group("courseid")
		else #filter.to_i == 2
			@groups = UserReport.select("
							distinct(department) as fullname,
							count(distinct userid) as alumnos,
							institution").where("
							lower(institution) = lower('#{institution}') and
							coursename is not null and
							coursename <> '' and
							created_at = (select max(created_at) from user_reports)").group("department")
		end	
	end

	def find_group_members(institution,group,filter)
		if filter.to_i == 1 || filter.nil? #miembros de cursos
			UserReport.select("
							courseid,
							coursename,
							userid,
							firstname,
							lastname,
							institution,
							department").where("
							institution = '#{institution}' and
							coursename = '#{group}'").group("userid")
		else #filter.to_i == 2
			UserReport.select("
							courseid,
							coursename,
							userid,
							firstname,
							lastname,
							institution,
							department").where("
							institution = '#{institution}' and
							department = '#{group}'").group("userid")
		end
	end
	
	def get_resp_info(inclasswork)

		if inclasswork.nil? || inclasswork == 0
			return "No hay datos suficientes registrados a la fecha"
		else
			case inclasswork.round
			when 1
				return "Mal trabajo en clases"
			when 2
				return "Insuficiente"
			when 3
				return "Suficiente, pero se recomienda mejorar"
			when 4
				return "Buen trabajo en clases"
			when 5
				return "Excelente trabajo en clases"
			end
		end
		


	end

	def grade_parser(grade)
		#transforma notas desde una escala de 0 a 61 a la escala chilena
		scale = ['1.0','1.1','1.2','1.3','1.4','1.5','1.6','1.7','1.8','1.9','2.0','2.1','2.2','2.3','2.4','2.5','2.6','2.7','2.8','2.9','3.0','3.1','3.2','3.3','3.4','3.5','3.6','3.7','3.8','3.9','4.0','4.1','4.2','4.3','4.4','4.5','4.6','4.7','4.8','4.9','5.0','5.1','5.2','5.3','5.4','5.5','5.6','5.7','5.8','5.9','6.0','6.1','6.2','6.3','6.4','6.5','6.6','6.7','6.8','6.9','7.0']
		if grade.nil?
			return "-"
		else
			if grade >= 0 && grade <= 61
				scale[grade-1]
			else
				grade.to_s+'%'
			end
		end
	end

	def grade_promedio(homework,writing_tests,tests_teg,tests,oral_tests)

		weight = 0
		if homework != 0 && !homework.nil?
			weight = weight + 0.3
		end

		if writing_tests != 0 && !writing_tests.nil?
			weight = weight + 0.2
		end

		if tests_teg != 0 && !tests_teg.nil?
			weight = weight + 0.2
		end

		if tests != 0 && !tests.nil?
			weight = weight + 0.15
		end

		if oral_tests != 0 && !oral_tests.nil?
			weight = weight + 0.15
		end

		if weight == 0
			return "-"
		else
			grade = (0.3/weight)*homework + (0.2/weight)*writing_tests + (0.2/weight)*tests_teg + (0.15/weight)*tests + (0.15/weight)*oral_tests
		end
		
		return grade_parser(grade)
	end
end
