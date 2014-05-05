class RemoveValueFromHorseConditions < ActiveRecord::Migration
  def change
  	remove_column :horse_conditions, :value, :boolean
  end
end
