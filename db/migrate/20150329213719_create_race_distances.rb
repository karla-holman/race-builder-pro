class CreateRaceDistances < ActiveRecord::Migration
  def change
    create_table :race_distances do |t|
      t.integer :race_id
      t.integer :distance
      t.string :distance_type
      t.integer :numerator
      t.integer :denominator
      t.integer :yards
      t.timestamps
    end
  end
end
