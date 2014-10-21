class RenameColumnWeekendTel < ActiveRecord::Migration
  def change
  	remove_column :tels, :weekend_start, :datetime
  	add_column :tels, :start_date, :date
  	add_column :tels, :end_date, :date
  end
end
