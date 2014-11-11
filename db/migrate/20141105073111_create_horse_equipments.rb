class CreateHorseEquipments < ActiveRecord::Migration
  def change
    create_table :horse_equipments do |t|
      t.integer :horse_id
      t.integer :equipment_id
      t.timestamps
    end
  end
end
