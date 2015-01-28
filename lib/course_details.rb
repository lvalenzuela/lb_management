module CourseDetails
	#funciones comunes para aquellas secciones donde se requiere editar los detalles
	#de un curso que fue originalmente instanciado en moodle, asociandolo con un curso
	#en summit.

	
	def get_students_qty_for_moodle_course(courseid)
		#retorna la cantidad de estudiantes registrados en el curso
		#segun el ultimo reporte de asistencia obtenido
		return StudentAttendanceReport.where(:courseid => courseid, :created_at => Date.today).count("distinct userid")
	end

	def get_teacher_for_moodle_course(courseid)
		#retorna el primer profesor asignado al curso segun la vista de moodle
		return MoodleRoleAssignationV.where(:courseid => courseid, :roleid => 9).first().userid
	end

	def replicate_moodle_course_sessions(courseid, commerce_course_id)
		moodle_sessions = MoodleCourseSessionV.where(:courseid => courseid).order("session_date ASC")
		counter = 1
		moodle_sessions.each do |session|
			new_session = CourseSession.new()
			new_session.commerce_course_id = commerce_course_id
			new_session.moodle_course_id = courseid
			new_session.startdatetime = session.session_date
			new_session.session_number = counter
			new_session.save!
			#se aumenta el contador y se guarda la ultima fecha registrada
			counter+=1
		end
		#retorna la fecha de la última sesion registrada
		return moodle_sessions.last.session_date
	end

	def clear_course_sessions(courseid, commerce_course_id)
		#Elimina las sessiones de un curso en summit.
		CourseSession.where(:moodle_course_id => courseid, :commerce_course_id => commerce_course_id).destroy_all
	end
end