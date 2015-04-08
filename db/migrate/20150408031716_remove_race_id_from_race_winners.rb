class RemoveRaceIdFromRaceWinners < ActiveRecord::Migration
  def change
  	remove_column :race_winners, :race_id, :integer
  	add_column :race_winners, :race_title, :string
  end
end
