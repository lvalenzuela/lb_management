class ChangeContextFields < ActiveRecord::Migration
  def change
  	rename_column :contexts, :name, :descriptionid
  	change_column :contexts, :descriptionid, :integer
  end
end
