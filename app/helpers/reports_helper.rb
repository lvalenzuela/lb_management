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

	def find_grades(user_id,course_id)

		query = "select 
					avg(case when lower(gc.fullname) = '?' then gg.finalgrade end) as assistance,
					avg(case when lower(gc.fullname) = 'homework' then gg.finalgrade end) as homework,
					avg(case when lower(gc.fullname) = 'writing test' then gg.finalgrade end) as writing_test,
					avg(case when lower(gc.fullname) = 'tests t.e.g.' then gg.finalgrade end) as tests_teg,
					avg(case when lower(gc.fullname) = 'tests' then gg.finalgrade end) as tests,
					avg(case when lower(gc.fullname) = 'oral tests' then gg.finalgrade end) as oral_tests
				from mdl_grade_categories as gc
				left join mdl_grade_items as gi
					on gi.categoryid = gc.id 
				left join mdl_grade_grades as gg
					on gg.itemid = gi.id and gg.userid = 340
				where 
					gc.courseid = 137
					and gc.depth = 2"

		grades = GradeGrades.find_by_sql(query)
		return grades.first()
	end

	def get_user_assignments(user_id, course_id)
		query = "select
					user.id as userid,
					(case when assign_sub.timemarked != 0 then from_unixtime(assign_sub.timemarked) else 0 end) as entrega_alumno,
					(case when assign.timedue != 0 then from_unixtime(assign.timedue) else 0 end) as fecha_entrega,
					(case when assign.timeavailable != 0 then from_unixtime(assign.timeavailable) else 0 end) as fecha_habilitada,
					assign_sub.grade as nota
				from mdl_assignment_submissions as assign_sub
				inner join mdl_assignment as assign
					on assign_sub.assignment = assign.id
				inner join mdl_user as user
					on assign_sub.userid = user.id and user.id = #{user_id}
				where
					assign.course = #{course_id}"

		assignments = User.find_by_sql(query)

		ontime = 0
		late = 0
		if !assignments.empty?
			assignments.each do |a|
				if a.fecha_entrega != 0 && a.entrega_alumno <= a.fecha_entrega
					ontime +=1 #tarea entregada a tiempo
				elsif a.fecha_entrega != 0 && a.entrega_alumno > a.fecha_entrega
					late +=1 #tarea entregada tarde
				else #a.fecha_entrega == 0
					#no se definio una fecha de entrega
					#por lo tanto la tarea fue entregada a tiempo
					ontime +=1
				end
			end
		end

		if ontime != 0 || late != 0 
			ontime_pct = ontime*100/(late+ontime)
		else
			ontime_pct = -1 #no hay entregas registradas
		end

		return ontime_pct
	end

	def get_last_access(user_id, course_id)
		query = "select
					from_unixtime(timeaccess) as last_access
				from mdl_user_lastaccess
				where
					courseid = #{course_id}
					and userid = #{user_id}"

		last_access = User.find_by_sql(query)

		if last_access.empty?
			return "No hay accesos al curso registrados."
		else
			return last_access.first().last_access.strftime("%d/%m/%Y %I:%M %p")
		end
	end
	
	def get_resp_info(user_id, course_id)
		query = "select
					att_log.studentid as userid,
					att_log.inclasswork as inclasswork,
					att_log.attitude as attitude,
					att_log.remarks as remarks
				from mdl_attendance_log as att_log
				inner join mdl_attendance_sessions as att_sess
					on att_log.sessionid = att_sess.id
					and att_sess.attendanceid in (select id from mdl_attforblock where course = #{course_id})
					and att_sess.lasttaken is not null
				where
					att_log.inclasswork != 0
					and att_log.attitude != 0
					and att_log.studentid = #{user_id}"

		resp_info = User.find_by_sql(query)

		avg_count = 0
		raw_inclasswork = 0
		#se eliminan los 0, dado que son inasistencias o datos faltantes
		resp_info.each do |resp|
			if resp.inclasswork != 0
				raw_inclasswork += resp.inclasswork
				avg_count +=1
			end
		end

		if avg_count == 0
			return "No hay datos suficientes registrados a la fecha"
		else
			inclasswork = raw_inclasswork/avg_count
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

	def get_att_sessions(course_id)

		query = "select count(*) as sessions
				from mdl_attendance_sessions
				where attendanceid in(select id from mdl_attforblock where course = #{course_id})"

		att_sessions = AttendanceSession.find_by_sql(query)
		return att_sessions.first().sessions
	end

	def user_att_info(user_id, course_id)
		query = "select
					count(distinct date) as clases_dictadas,
					sum(case when acronym = 'P' then 1 else 0 end) as presente,
					sum(case when acronym = 'A' then 1 else 0 end) as ausente,
					sum(case when acronym = 'T' then 1 else 0 end) as tarde
				from(
				select
					att_stat.acronym as acronym,
					att_stat.description as description,
					from_unixtime(att_log.timetaken) as date
				from mdl_attendance_log as att_log
				inner join mdl_attendance_statuses as att_stat
					on att_log.statusid = att_stat.id
				where
					att_log.studentid = #{user_id}
					and att_log.sessionid in (	select id
												from mdl_attendance_sessions
												where
													lasttakenby != 0 
													and attendanceid in(select id from mdl_attforblock where course = #{course_id}))) as t"

		att_taken = Attforblock.find_by_sql(query)
		return att_taken.first()
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

	def grade_promedio(grades)
		weight = 0
		homework = grades.homework.nil? ? 0 : grades.homework
		writing_test = grades.writing_test.nil? ? 0 : grades.writing_test
		tests_teg = grades.tests_teg.nil? ? 0 : grades.tests_teg
		tests = grades.tests.nil? ? 0 : grades.tests
		oral_tests = grades.oral_tests.nil? ? 0 : grades.oral_tests

		if !grades.homework.nil?
			weight = weight + 0.3
		end

		if !grades.writing_test.nil?
			weight = weight + 0.2
		end

		if !grades.tests_teg.nil?
			weight = weight + 0.2
		end

		if !grades.tests.nil?
			weight = weight + 0.15
		end

		if !grades.oral_tests.nil?
			weight = weight + 0.15
		end

		if weight == 0
			return "-"
		else
			grade = (0.3/weight)*homework + (0.2/weight)*writing_test + (0.2/weight)*tests_teg + (0.15/weight)*tests + (0.15/weight)*oral_tests
		end
		
		return grade_parser(grade)
	end
end
