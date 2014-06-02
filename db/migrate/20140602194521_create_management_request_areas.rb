class CreateManagementRequestAreas < ActiveRecord::Migration
  def change
    create_table :management_request_areas do |t|

      t.timestamps
    end
  end
end
