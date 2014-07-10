class AddQuotationText < ActiveRecord::Migration
  def up
  	add_column :quotations, :textbody, :text
  	add_column :quotations, :textfooter, :text
  end

  def down
  	remove_column :quotations, :textbody
  	remove_column :quotations, :textfooter
  end
end
