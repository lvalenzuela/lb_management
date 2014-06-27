class CreateContexts < ActiveRecord::Migration
  def up
    create_table :contexts do |t|
    	t.string :name
    	t.integer :instanceid
    	t.timestamps
    end
  end

  def down
  	drop_table :contexts
  end
end
