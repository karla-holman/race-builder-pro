class CreateRaceDates < ActiveRecord::Migration
  def change
    create_table :race_dates do |t|
      t.date :date
      t.integer :race_id
      t.timestamps
    end
  end
end
