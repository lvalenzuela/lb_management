class CreateRequestTags < ActiveRecord::Migration
  def change
    create_table :request_tags do |t|

      t.timestamps
    end
  end
end
