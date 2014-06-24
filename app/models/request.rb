class Request < ActiveRecord::Base
	before_create :set_defaults
	validates :userid, :statusid, :subject, :areaid, :priorityid, :statusid, presence: true

	def set_defaults
		#Asigna solicitudes de forma automatica al encargado del área al que fueron realizadas
		self.receiverid = RequestArea.find(self.areaid).area_manager
		#Asigna un tag vacio a la solicitud
		self.tagid = 1
	end
end
