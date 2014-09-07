class AddWeekNumberToTels < ActiveRecord::Migration
  def change
  	add_column :tels, :week_number, :integer
  end
end
