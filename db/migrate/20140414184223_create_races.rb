class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :race_number
      t.timestamps
    end
  end
end
