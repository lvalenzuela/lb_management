class AttendanceSession < ActiveRecord::Base
	self.table_name = 'mdl_attendance_sessions'
	self.primary_key = 'id'
end
