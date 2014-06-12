class Request < ActiveRecord::Base
	before_create :set_default_receiver
	validates :userid, :statusid, :subject, :areaid, :priorityid, :statusid, :duedate, presence: true

	def set_default_receiver
		self.receiverid = RequestArea.find(self.areaid).area_manager
	end
end
