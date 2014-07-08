class CreateQuotationStatuses < ActiveRecord::Migration
  def up
    create_table :quotation_statuses do |t|
    	t.string :statusname
    	t.string :description
      	t.timestamps
    end
  end

  def down
  	drop_table :quotation_statuses
  end
end
