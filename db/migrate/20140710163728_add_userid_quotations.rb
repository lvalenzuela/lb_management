class AddUseridQuotations < ActiveRecord::Migration
  def up
  	add_column :quotations, :userid, :integer
  end

  def down
  	remove_column :quotations, :userid
  end
end
