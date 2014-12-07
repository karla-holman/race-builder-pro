class ChangeEntryDateToDatetime < ActiveRecord::Migration
  def change
  	change_column :tels, :entry_date, :datetime
  end
end
