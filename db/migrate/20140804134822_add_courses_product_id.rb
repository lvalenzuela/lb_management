class AddCoursesProductId < ActiveRecord::Migration
  def up
  	rename_column :courses, :productpriceid, :zoho_product_id
  	rename_column :courses, :statusid, :course_status_id
  end

  def down
  	rename_column :courses, :zoho_product_id, :productpriceid
  	rename_column :courses, :course_status_id, :statusid
  end
end
