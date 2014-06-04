class CreateRequestAreas < ActiveRecord::Migration
  def change
    create_table :request_areas do |t|

      t.timestamps
    end
  end
end
