class CreateHorseMeets < ActiveRecord::Migration
  def change
    create_table :horse_meets do |t|
   	  t.integer :horse_id
      t.integer :meet_id
      t.integer :starts
      
      t.timestamps
    end
  end
end
