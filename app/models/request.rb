class Request < ActiveRecord::Base
	before_create :set_default_receiver
	validates :userid, :statusid, :subject, :areaid, :priorityid, :statusid, :duedate, presence: true

	def set_default_receiver
		#Asigna solicitudes de forma automatica al encargado del área al que fueron realizadas
		self.receiverid = RequestArea.find(self.areaid).area_manager
	end
end
