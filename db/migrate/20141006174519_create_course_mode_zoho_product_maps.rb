class CreateCourseModeZohoProductMaps < ActiveRecord::Migration
  def up
    create_table :course_mode_zoho_product_maps do |t|
    	t.string :product_name
    	t.string :zoho_product_id
    	t.integer :course_mode_id
    	t.boolean :enabled
      	t.timestamps
    end
  end

  def down
  	drop_table :course_mode_zoho_product_maps
  end
end
