class Area < ActiveRecord::Base
	has_many :request_area_titles
	after_create :register_instance

	def register_instance
		#Se registra la instancia junto con su contexto en la tabla de contextos
		#Un área de longbourn se asocia al contexto de gestión, con ID = 2
		#Descripciones de contexto
		#1.- Sistema
		#2.- Gestión
		Context.create(:descriptionid => 2, :instanceid => self.id)
	end
end
