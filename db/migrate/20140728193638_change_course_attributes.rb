class ChangeCourseAttributes < ActiveRecord::Migration
  def up
  	change_column :courses, :mode, :string
  	change_column :courses, :productpriceid, :string
  end

  def down
  	change_column :courses, :mode, :integer
  	change_column :courses, :productpriceid, :integer
  end
end
