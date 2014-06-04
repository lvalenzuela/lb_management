class CreateRequestStatuses < ActiveRecord::Migration
  def change
    create_table :request_statuses do |t|

      t.timestamps
    end
  end
end
