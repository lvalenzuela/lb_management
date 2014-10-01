class CreateCourseObservations < ActiveRecord::Migration
  def up
    create_table :course_observations do |t|
    	t.integer :course_id
    	t.integer :user_id
    	t.string :subject
    	t.text :message
    	t.attachment :attachment
      	t.timestamps
    end
  end

  def down
  	drop_table :course_observations
  end
end
