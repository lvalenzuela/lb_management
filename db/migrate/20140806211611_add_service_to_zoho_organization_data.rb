class AddServiceToZohoOrganizationData < ActiveRecord::Migration
  def up
  	add_column :zoho_organization_data, :service, :string, after: :organization_name
  end

  def down
  	remove_column :zoho_organization_data, :service
  end
end
