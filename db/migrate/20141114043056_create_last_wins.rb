class CreateLastWins < ActiveRecord::Migration
  def change
    create_table :last_wins do |t|
    	t.datetime :date
    	t.string :distance_type
    	t.integer :distance
    	t.decimal :money_earned
      t.timestamps
    end
  end
end
