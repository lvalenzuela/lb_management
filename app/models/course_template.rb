class CourseTemplate < ActiveRecord::Base
	before_create :set_defaults
	after_create :create_template_sessions
	after_update :adjust_template_sessions

	def set_defaults
		self.deleted = 0
	end

	def create_template_sessions
		#Se crean las sesiones correspondientes al curso
		for session in 1..(self.total_sessions)
			CourseTemplateSession.create(:course_template_id => self.id, :session_number => session)
		end
	end

	def adjust_template_sessions
		last_session = CourseTemplateSession.where(:course_template_id => self.id).order("session_number DESC").first()
		if last_session.blank?
			create_sessions
		else
			current_total_sessions = last_session.session_number
			if current_total_sessions < self.total_sessions
				#Crear las sesiones que faltan
				for session in (current_total_sessions)..(self.total_sessions)
					CourseTemplateSession.create(:course_template_id => self.id, :session_number => session)
				end
			elsif current_total_sessions > self.total_sessions
				#Borrar las sesiones que sobran
				CourseTemplateSession.where("session_number > #{self.total_sessions}").destroy_all
			end
		end
	end
end
