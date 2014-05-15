class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |t|

      t.timestamps
    end
  end
end
