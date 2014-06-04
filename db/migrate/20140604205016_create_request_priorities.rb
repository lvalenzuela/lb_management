class CreateRequestPriorities < ActiveRecord::Migration
  def change
    create_table :request_priorities do |t|

      t.timestamps
    end
  end
end
