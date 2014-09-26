class AddTeacherQualityToUser < ActiveRecord::Migration
  def up
  	add_column :users, :teacher_level_id, :integer, :after => :system_role_id
  end

  def down
  	remove_column :users, :teacher_level_id
  end
end
