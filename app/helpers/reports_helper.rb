module ReportsHelper

	def find_members(institution,group,filter)
		if filter == "1" || filter.nil? #Curso
			query = "select
						course.id as courseid,
						course.fullname as course_fullname,
						user.id as userid,
						user.firstname as firstname,
						user.lastname as lastname,
						user.institution as institution,
						user.department as department
					from mdl_user as user
					left join(
						select
							r_assign.userid,
							context.instanceid
						from mdl_role_assignments as r_assign
						inner join mdl_context as context
							on r_assign.contextid = context.id and contextlevel = 50
						where
							r_assign.roleid in (select id from mdl_role where shortname = 'student')) as t
						on user.id = t.userid
					left join mdl_course as course
						on course.id = t.instanceid
					where
						user.institution is not null
						and user.institution != ''
						and user.institution like '%#{institution}%'
						and user.deleted != 1
						and course.fullname is not null
						and course.fullname != ''
						and course.fullname = '#{group}'
					group by user.id"
		elsif filter == "2" #Departamento
			query = "select
						course.id as courseid,
						course.fullname as course_fullname,
						user.id as userid,
						user.firstname as firstname,
						user.lastname as lastname,
						user.institution as institution,
						user.department as department
					from mdl_user as user
					left join(
						select
							r_assign.userid,
							context.instanceid
						from mdl_role_assignments as r_assign
						inner join mdl_context as context
							on r_assign.contextid = context.id and contextlevel = 50
						where
							r_assign.roleid in (select id from mdl_role where shortname = 'student')) as t
						on user.id = t.userid
					left join mdl_course as course
						on course.id = t.instanceid
					where
						user.institution is not null
						and user.institution != ''
						and user.institution like '%experian%'
						and user.department = '#{group}'
						and user.deleted != 1
						and course.fullname is not null
						and course.fullname != ''
					group by user.id;"
		end

		members = User.find_by_sql(query)
	end

	def find_course_by_institution(institution, filter)
		if filter == "1" || filter.nil? #Por Curso
			query = "select
						distinct(course.id) as id,
						course.fullname as fullname,
						user.institution as institution,
						count(distinct(user.id)) as alumnos,
						count(distinct(user.department)) as departments
					from mdl_user as user
					left join(
						select
							r_assign.userid,
							context.instanceid
						from mdl_role_assignments as r_assign
						inner join mdl_context as context
							on r_assign.contextid = context.id and contextlevel = 50
						where
							r_assign.roleid in (select id from mdl_role where shortname = 'student')) as t
						on user.id = t.userid
					left join mdl_course as course
						on course.id = t.instanceid
					where
						user.institution is not null
						and user.institution != ''
						and user.institution like '%#{institution}%'
						and user.deleted != 1
						and course.fullname is not null
						and course.fullname != ''
					group by course.id"
		elsif filter == "2" #Por Departamento
			query = "select
						distinct(user.department) as fullname,
						count(distinct(user.id)) as alumnos,
						user.institution
					from mdl_user as user
					left join(
						select
							r_assign.userid,
							context.instanceid
						from mdl_role_assignments as r_assign
						inner join mdl_context as context
							on r_assign.contextid = context.id and contextlevel = 50
						where
							r_assign.roleid in (select id from mdl_role where shortname = 'student')) as t
						on user.id = t.userid
					left join mdl_course as course
						on course.id = t.instanceid
					where
						user.institution is not null
						and user.institution != ''
						and user.institution like '%#{institution}%'
						and user.deleted != 1
						and course.fullname is not null
						and course.fullname != ''
					group by user.department"
		end
		
		course = Course.find_by_sql(query)
	end

	def find_institutions(institution_name)

		if institution_name.nil?
			query_conditions = ""
		else
			query_conditions = "and user.institution like '%#{institution_name}%'"
		end

		query = "select
					user.institution as institution,
					count(distinct(user.department)) as departments,
					count(distinct(course.id)) as cursos,
					count(distinct(user.id)) as alumnos
				from mdl_user as user
				left join(
					select
						r_assign.userid,
						context.instanceid
					from mdl_role_assignments as r_assign
					inner join mdl_context as context
						on r_assign.contextid = context.id and contextlevel = 50
					where
						r_assign.roleid in (select id from mdl_role where shortname = 'student')) as t
					on user.id = t.userid
				left join mdl_course as course
					on course.id = t.instanceid
				where
					user.institution is not null
					and user.institution != ''
					#{query_conditions}
					and user.deleted != 1
					and course.fullname is not null
					and course.fullname != ''
				group by user.institution"
		

		institutions = User.find_by_sql(query)
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
		scale = ['1,0','1,1','1,2','1,3','1,4','1,5','1,6','1,7','1,8','1,9','2,0','2,1','2,2','2,3','2,4','2,5','2,6','2,7','2,8','2,9','3,0','3,1','3,2','3,3','3,4','3,5','3,6','3,7','3,8','3,9','4,0','4,1','4,2','4,3','4,4','4,5','4,6','4,7','4,8','4,9','5,0','5,1','5,2','5,3','5,4','5,5','5,6','5,7','5,8','5,9','6,0','6,1','6,2','6,3','6,4','6,5','6,6','6,7','6,8','6,9','7,0']
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
