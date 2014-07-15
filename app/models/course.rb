class Course < ActiveRecord::Base
	before_create :set_defaults

	def set_defaults
		#Un curso creado no es activo instantaneamente, hay que activarlo posteriormente
		#los estados de los cursos son los siguientes
		# 1. Desactivado -> valor por defecto al crear un curso
		# 2. Activo
		# 3. Cancelado
		self.statusid = 1
	end
end
