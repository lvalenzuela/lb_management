class CreateCourseFeatures < ActiveRecord::Migration
  def up
    create_table :course_features do |t|
    	t.integer :course_id
    	t.string :feature_name
    	t.string :feature_description
      	t.timestamps
    end
  end

  def down
  	drop_table :course_features
  end
end
