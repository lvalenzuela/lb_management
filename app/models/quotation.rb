class Quotation < ActiveRecord::Base
	before_create :fix_discount

	def fix_discount
		if self.discount.nil? || self.discount.blank?
			self.discount = 0
		end
	end
end
