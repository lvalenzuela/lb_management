class CreateManagementNotifications < ActiveRecord::Migration
  def change
    create_table :management_notifications do |t|

      t.timestamps
    end
  end
end
