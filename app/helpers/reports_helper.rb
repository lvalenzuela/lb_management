module ReportsHelper
	def find_grades(user_id,course_id)
		grades = GradeGrades.find_by_sql("	select 
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
												and gc.depth = 2;")
		return grades.first()
	end

	def get_att_sessions(course_id)
		att_sessions = AttendanceSession.find_by_sql("	select
															count(*) as sessions
														from mdl_attendance_sessions
														where
															attendanceid in(select id from mdl_attforblock where course = #{course_id})")
		return att_sessions.first().sessions
	end

	def user_att_info(user_id, course_id)
		att_taken = Attforblock.find_by_sql("	select
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
													and att_log.sessionid in (	select
																					id
																				from mdl_attendance_sessions
																				where
																					lasttakenby != 0 
																					and attendanceid in(select id from mdl_attforblock where course = #{course_id}))) as t")
		return att_taken.first()
	end

	def grade_parser(grade)
		#transforma notas desde una escala de 0 a 61 a la escala chilena
		scale = ['1,0','1,1','1,2','1,3','1,4','1,5','1,6','1,7','1,8','1,9','2,0','2,1','2,2','2,3','2,4','2,5','2,6','2,7','2,8','2,9','3,0','3,1','3,2','3,3','3,4','3,5','3,6','3,7','3,8','3,9','4,0','4,1','4,2','4,3','4,4','4,5','4,6','4,7','4,8','4,9','5,0','5,1','5,2','5,3','5,4','5,5','5,6','5,7','5,8','5,9','6,0','6,1','6,2','6,3','6,4','6,5','6,6','6,7','6,8','6,9','7,0']
		if grade.nil?
			return "Aún no se han realizado."
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
