class CreateCourseAlarmParameters < ActiveRecord::Migration
  def up
    create_table :course_alarm_parameters do |t|
    	t.string :param_name
    	t.string :param_description
    	t.string :value
    	t.timestamps
    end
  end

  def down
  	drop_table :course_alarm_parameters
  end
end
