class DropTelAndDayToRace < ActiveRecord::Migration
  def change
  	remove_column :races, :tel_id, :integer
  	add_column :races, :day_id, :integer
  end
end
