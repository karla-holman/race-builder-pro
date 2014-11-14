class AddHorseToLastWins < ActiveRecord::Migration
  def change
  	add_column :last_wins, :horse_id, :integer
  end
end
