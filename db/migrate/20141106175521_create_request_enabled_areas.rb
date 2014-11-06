class CreateRequestEnabledAreas < ActiveRecord::Migration
  def up
    create_table :request_enabled_areas do |t|
    	t.integer :area_id
      t.timestamps
    end
    RequestEnabledArea.create(:area_id => 4) #habilitación inmediata del area de sistemas y procesos
  end

  def down
  	drop_table :request_enabled_areas
  end
end
