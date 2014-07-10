class AddTitleToFormats < ActiveRecord::Migration
  def up
  	add_column :quotation_defaults, :title, :string
  end

  def down
  	remove_column :quotation_defaults, :title
  end
end
