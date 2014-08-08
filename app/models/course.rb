class Course < ActiveRecord::Base
	before_create :set_defaults
	validates :coursename, :start_date, :mode, :course_level_id, presence: true

	def set_defaults
		#Un curso creado no es activo instantaneamente, hay que activarlo posteriormente
		#los estados de los cursos son los siguientes
		# 1. Desactivado -> valor por defecto al crear un curso
		# 2. Activo
		# 3. Cancelado
		self.course_status_id = 1
	end
end
