class AttendanceStatus < ActiveRecord::Base
	self.table_name = 'mdl_attendance_statuses'
	self.primary_key = 'id'
end
