class RemoveValueFromRaceConditions < ActiveRecord::Migration
  def change
  	remove_column :race_conditions, :value, :boolean
  end
end
