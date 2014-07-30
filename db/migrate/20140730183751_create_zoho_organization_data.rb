class CreateZohoOrganizationData < ActiveRecord::Migration
  def up
    create_table :zoho_organization_data do |t|
    	t.string :authtoken
    	t.string :organization_name
    	t.string :organization_id
      	t.timestamps
    end
  end

  def down
  	drop_table :zoho_organization_data
  end
end
