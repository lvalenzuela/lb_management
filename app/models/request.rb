class Request < ActiveRecord::Base
	before_create :set_defaults, :clean_unsafe_params
	before_update :clean_unsafe_params
	validates :subject, :areaid, :priorityid, presence: true

	has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	has_attached_file :attach

	def set_defaults
		#se define el estado de la solicitud como pendiente
		self.statusid = 1
		if !self.tagid
			self.receiverid = nil
		else
			tag = RequestTag.find(self.tagid)
			if tag.blank?
				#no se le asigna a nadie
				self.receiverid = nil
			else
				#se le asigna al encargado de la categoría
				self.receiverid = tag.default_user_id
			end
		end

		weekend = [0,6] #[sabado, domingo]
		case self.priorityid
		when 1
			#plazo mínimo de 1 días
			date = Time.now + 1
			date += 1.days while weekend.include?(date.wday)
			self.duedate = date
		when 2
			#plazo mínimo de 2 días
			date = Time.now + 2.days
			date += 1.days while weekend.include?(date.wday)
			self.duedate = date
		when 3
			#plazo mínimo de 3 días
			date = Time.now + 3.days
			date += 1.days while weekend.include?(date.wday)
			self.duedate = date
		else
			#Plazo hasta el viernes de la semana siguiente
			self.duedate = (Time.now + 1.weeks).end_of_week - 2.days
		end
	end

	def clean_unsafe_params
		#Limpia caracteres potencialmente conflictivos antes de la insercion
		self.subject = self.subject.encode('UTF-8', :invalid => :replace, :undef => :replace)
		self.request = self.request.encode('UTF-8', :invalid => :replace, :undef => :replace)
	end
end
