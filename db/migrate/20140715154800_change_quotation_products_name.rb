class ChangeQuotationProductsName < ActiveRecord::Migration
  def up
  	rename_table :quotation_products, :quotation_courses
  end

  def down
  	rename_table :quotation_courses, :quotation_products
  end
end
