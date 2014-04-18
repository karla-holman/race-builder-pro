class CreateRaceConditions < ActiveRecord::Migration
  def change
    create_table :race_conditions do |t|
      t.integer :race_id
      t.integer :condition_id
      t.boolean :value

      t.timestamps
    end
  end
end
