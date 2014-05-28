class CreateManagementRequestStatuses < ActiveRecord::Migration
  def change
    create_table :management_request_statuses do |t|

      t.timestamps
    end
  end
end
