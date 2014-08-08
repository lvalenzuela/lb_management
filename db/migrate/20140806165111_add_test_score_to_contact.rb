class AddTestScoreToContact < ActiveRecord::Migration
  def up
  	add_column :contact_people, :test_score, :double, :precision => 3, :scale => 2, after: :zoho_enabled
  	add_column :contact_people, :course_level_id, :integer, after: :test_score
  	add_column :courses, :course_level_id, :integer, after: :description
  end

  def down
  	remove_column :contact_people, :test_score
  	remove_column :contact_people, :course_level_id
  	remove_column :courses, :course_level_id
  end
end
