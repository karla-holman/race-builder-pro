class CreateHorseraces < ActiveRecord::Migration
  def change
    create_table :horseraces do |t|
      t.integer :horse_id
      t.integer :race_id
      t.datetime :entered
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
