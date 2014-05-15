class CreateAttendanceLogs < ActiveRecord::Migration
  def change
    create_table :attendance_logs do |t|

      t.timestamps
    end
  end
end
