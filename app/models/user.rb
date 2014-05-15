class User < ActiveRecord::Base
	self.table_name = 'mdl_user'
	self.primary_key = 'id'
end
