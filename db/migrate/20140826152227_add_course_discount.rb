class AddCourseDiscount < ActiveRecord::Migration
  def up
  	add_column :courses, :discount_pct, :string, after: :start_date
  	add_column :courses, :discount_factor, :integer, after: :discount_pct
  end

  def down
  	remove_column :courses, :discount_pct
  	remove_column :courses, :discount_factor
  end
end
