class AddPriceToZohoProducts < ActiveRecord::Migration
  def up
  	add_column :course_mode_zoho_product_maps, :price, :string, :after => :course_mode_id
  end

  def down
  	remove_column :course_mode_zoho_product_maps, :price
  end
end
