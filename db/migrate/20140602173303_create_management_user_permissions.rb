class CreateManagementUserPermissions < ActiveRecord::Migration
  def change
    create_table :management_user_permissions do |t|

      t.timestamps
    end
  end
end
