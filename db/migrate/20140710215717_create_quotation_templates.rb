class CreateQuotationTemplates < ActiveRecord::Migration
  def up
    create_table :quotation_templates do |t|
    	t.string :title
    	t.text :body
    	t.text :footer
      	t.timestamps
    end
  end

  def down
  	drop_table :quotation_templates
  end
end
