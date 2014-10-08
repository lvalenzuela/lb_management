class CourseMode < ActiveRecord::Base
	before_create :set_defaults

	def set_defaults
		#cuando se crea una modalidad de cursos se asume que esta instantaneamente activa
		self.enabled = true
	end
end
