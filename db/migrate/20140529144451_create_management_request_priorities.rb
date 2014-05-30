class CreateManagementRequestPriorities < ActiveRecord::Migration
  def change
    create_table :management_request_priorities do |t|

      t.timestamps
    end
  end
end
