class WebUser < ActiveRecord::Base
	before_create :set_defaults
	before_update :reset_name
	validates :firstname, :lastname, :email, :gender, :presence => true

	def set_defaults
		#valores por defecto utilizados para la creacion de usuarios
		if self.name.nil?
			self.name = self.firstname+" "+self.lastname
		end
	end

	def reset_name
		#en caso de que haya cambiado el nombre del usuario ... por algun motivo
		self.name = self.firstname + " " + self.lastname
	end
end
