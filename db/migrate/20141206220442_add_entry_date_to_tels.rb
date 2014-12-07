class AddEntryDateToTels < ActiveRecord::Migration
  def change
  	add_column :tels, :entry_date, :date
  end
end
