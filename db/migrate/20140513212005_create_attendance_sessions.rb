class CreateAttendanceSessions < ActiveRecord::Migration
  def change
    create_table :attendance_sessions do |t|

      t.timestamps
    end
  end
end
