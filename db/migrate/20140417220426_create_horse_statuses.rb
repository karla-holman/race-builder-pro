class CreateHorseStatuses < ActiveRecord::Migration
  def change
    create_table :horse_statuses do |t|
      t.integer :horse_id
      t.integer :status_id
      t.boolean :value

      t.timestamps
    end
  end
end
