class CreateRequestMessages < ActiveRecord::Migration
  def change
    create_table :request_messages do |t|

      t.timestamps
    end
  end
end
