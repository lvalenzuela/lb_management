class RoleAssignation < ActiveRecord::Base
	has_one :user
	has_one :role
	has_one :context
end
