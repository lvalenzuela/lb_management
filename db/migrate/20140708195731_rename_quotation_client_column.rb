class RenameQuotationClientColumn < ActiveRecord::Migration
  def up
  	rename_column :quotations, :clientid, :contactid
  end

  def down
  	rename_column :quotations, :contactid, :clientid
  end
end
