class RemoveQuotations < ActiveRecord::Migration
  def up
  	drop_table :quotation_courses
  	drop_table :quotations
  	drop_table :quotation_statuses
  	drop_table :quotation_templates
  end

  def down

  end
end
