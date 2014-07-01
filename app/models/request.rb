class Request < ActiveRecord::Base
	before_create :set_defaults, :clean_unsafe_params
	before_update :clean_unsafe_params
	validates :userid, :statusid, :subject, :areaid, :priorityid, :statusid, presence: true

	has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	has_attached_file :attach

	def set_defaults
		#Asigna un tag vacio a la solicitud
		self.tagid = 1
	end

	def clean_unsafe_params
		#Limpia caracteres potencialmente conflictivos antes de la insercion
		self.subject = self.subject.encode('UTF-8', :invalid => :replace, :undef => :replace)
		self.subject = self.request.encode('UTF-8', :invalid => :replace, :undef => :replace)
	end
end
