class CreateHorseFilterSettings < ActiveRecord::Migration
  def change
    create_table :horse_filter_settings do |t|
      t.integer :lower_claiming
      t.integer :upper_claiming
      t.integer :wins_id
      t.integer :age_id
      t.integer :sex_id
      t.integer :horse_id
      t.string :distance
      t.string :bred
      t.timestamps
    end
  end
end
