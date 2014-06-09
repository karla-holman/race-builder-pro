class CreateRaceWinners < ActiveRecord::Migration
  def change
    create_table :race_winners do |t|
    	t.integer :race_id
    	t.integer :horse_id

    	t.datetime :created_at
      t.datetime :updated_at
      t.timestamps
    end
  end
end
