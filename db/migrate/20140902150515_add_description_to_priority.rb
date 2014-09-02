class AddDescriptionToPriority < ActiveRecord::Migration
  def up
  	add_column :request_priorities, :term_desc, :string, after: :description
  end

  def down
  	remove_column :request_priorities, :term_desc
  end
end
