class AddColumnsWinnerPurseLevelToRaces < ActiveRecord::Migration
  def change
  	add_column :races, :winnner, :integer
  	add_column :races, :claiming_purse, :decimal
  	add_column :races, :claiming_level, :decimal
  end
end
