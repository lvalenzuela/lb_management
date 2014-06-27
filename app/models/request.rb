class Request < ActiveRecord::Base
	before_create :set_defaults
	validates :userid, :statusid, :subject, :areaid, :priorityid, :statusid, presence: true

	has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	has_attached_file :attach

	def set_defaults
		#Asigna un tag vacio a la solicitud
		self.tagid = 1
	end
end
