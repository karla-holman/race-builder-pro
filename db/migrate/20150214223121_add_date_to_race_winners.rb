class AddDateToRaceWinners < ActiveRecord::Migration
  def change
  	add_column :race_winners, :date, :date
  end
end
