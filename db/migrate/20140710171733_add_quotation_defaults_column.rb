class AddQuotationDefaultsColumn < ActiveRecord::Migration
  def up
  	add_column :quotation_defaults, :default, :integer
  end

  def down
  	remove_column :quotation_defaults, :default
  end
end
