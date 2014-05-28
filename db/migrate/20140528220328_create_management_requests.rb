class CreateManagementRequests < ActiveRecord::Migration
  def change
    create_table :management_requests do |t|

      t.timestamps
    end
  end
end
