class CreateManagementUsers < ActiveRecord::Migration
  def change
    create_table :management_users do |t|

      t.timestamps
    end
  end
end
