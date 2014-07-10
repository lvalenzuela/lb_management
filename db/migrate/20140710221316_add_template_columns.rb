class AddTemplateColumns < ActiveRecord::Migration
  def up
  	add_column :quotation_templates, :userid, :integer
  	add_column :quotation_templates, :default, :integer
  end

  def down
  	remove_column :quotation_templates, :userid
  	remove_column :quotation_templates, :default
  end
end
