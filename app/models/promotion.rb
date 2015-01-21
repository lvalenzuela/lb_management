class Promotion < ActiveRecord::Base
	validates :shortname, :fullname, :start_date, :end_date, :discount_index, presence: true
	validate :end_date_must_be_greater_than_start_date

	def end_date_must_be_greater_than_start_date
		if end_date < start_date
			errors.add(:end_date, "La fecha de término no puede ser menor a la fecha de inicio.")
		end
	end
end
