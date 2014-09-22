class CourseTemplate < ActiveRecord::Base
	before_create :set_defaults

	def set_defaults
		self.deleted = 0
	end
end
