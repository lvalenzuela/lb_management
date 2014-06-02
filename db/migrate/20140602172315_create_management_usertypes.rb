class CreateManagementUsertypes < ActiveRecord::Migration
  def change
    create_table :management_usertypes do |t|

      t.timestamps
    end
  end
end
