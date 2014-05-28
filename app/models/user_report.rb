class UserReport < ActiveRecord::Base
	self.table_name = 'management_user_reports'
	self.primary_key = 'id'
end
