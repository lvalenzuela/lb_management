class Course < ActiveRecord::Base
	self.table_name = 'mdl_course'
	self.primary_key = 'id'
end
