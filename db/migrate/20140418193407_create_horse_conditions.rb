class CreateHorseConditions < ActiveRecord::Migration
  def change
    create_table :horse_conditions do |t|
      t.integer :horse_id
      t.integer :condition_id
      t.boolean :value

      t.timestamps
    end
  end
end
