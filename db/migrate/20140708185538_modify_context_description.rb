class ModifyContextDescription < ActiveRecord::Migration
  def up
  	rename_column :contexts, :descriptionid, :typeid
  	rename_table :context_descriptions, :context_types
  	rename_column :context_types, :description, :type
  	add_column :context_types, :description, :string
  end

  def down
  	rename_column :contexts, :typeid, :descriptionid
  	remove_column :context_types, :description
  	rename_column :context_types, :type, :description
  	rename_table :context_types, :context_descriptions

  end
end
