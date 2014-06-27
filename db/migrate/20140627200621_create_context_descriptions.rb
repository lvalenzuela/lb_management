class CreateContextDescriptions < ActiveRecord::Migration
  def change
    create_table :context_descriptions do |t|
    	t.string :description
     	t.timestamps
    end
  end
end
