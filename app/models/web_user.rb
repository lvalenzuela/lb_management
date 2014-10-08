class WebUser < ActiveRecord::Base
	before_create :set_defaults
	validates :firstname, :lastname, :email, :gender, :presence => true

	def set_defaults
		#valores por defecto utilizados para la creacion de usuarios
		if self.name.nil?
			self.name = self.firstname+" "+self.lastname
		end
	end
end
