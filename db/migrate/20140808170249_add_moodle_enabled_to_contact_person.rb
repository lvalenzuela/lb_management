class AddMoodleEnabledToContactPerson < ActiveRecord::Migration
  def up
  	add_column :contact_people, :moodle_enabled, :boolean, after: :zoho_enabled
  end

  def down
  	remove_column :contact_people, :moodle_enabled
  end
end
