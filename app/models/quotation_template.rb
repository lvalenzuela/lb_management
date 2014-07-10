class QuotationTemplate < ActiveRecord::Base
	before_create :set_defaults
end
