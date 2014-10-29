class Course < ActiveRecord::Base
	before_create :set_defaults
	after_create :init_instance
	before_destroy :destroy_features, :destroy_sessions
	validates :coursename, :start_date, :mode, :course_level_id, :course_template_id, :zoho_product_id, presence: true

	def set_defaults
		#Un curso creado no es activo instantaneamente, hay que activarlo posteriormente
		#los estados de los cursos son los siguientes
		# 1. Desactivado -> valor por defecto al crear un curso
		# 2. Activo
		# 3. Cancelado
		self.course_status_id = 1
	end

	def init_instance
		#Crea un registro de la instancia de curso generada
		#Tipos de Instancia
		#1. Sistema
		#2. Areas
		#3. Cursos
		#4. Comercial
		Context.create(:typeid => 3, :instanceid => self.id)
	end

	def destroy_features
		CourseFeature.where(:course_id => self.id).destroy_all
	end

	def destroy_sessions
		CourseSession.where(:commerce_course_id => self.id).destroy_all
	end

	def count_students
		students = CourseMember.where(:course_id => self.id).count()
		if students.to_i == 0 && [1,2].include?(self.course_status_id)
			#no hay estudiantes en el curso, se considera desierto
			self.course_status_id = 1
			self.current_students_qty = 0
		else
			if [1,2].include?(self.course_status_id)
				#Si el curso esta en venta y tiene estudiantes
				#no se considera desierto
				self.course_status_id = 2
				self.current_students_qty = students.to_i
			end
		end
		self.save!
	end
end
