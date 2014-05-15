class AttendanceLog < ActiveRecord::Base
	self.table_name = 'mdl_attendance_log'
	self.primary_key = 'id'
end
