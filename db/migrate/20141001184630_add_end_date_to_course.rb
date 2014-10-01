class AddEndDateToCourse < ActiveRecord::Migration
  def up
  	add_column :courses, :end_date, :date, after: :start_date
  end

  def down
  	remove_column :courses, :end_date
  end
end
