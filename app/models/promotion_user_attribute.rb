class PromotionUserAttribute < ActiveRecord::Base
	before_create :set_sort_order

	def set_sort_order
		last_entry = PromotionUserAttribute.where(:promotion_id => self.promotion_id).order("sort_order DESC").first()
		if last_entry.blank?
			self.sort_order = 1
		else
			self.sort_order = last_entry.sort_order + 1
		end
	end
end
