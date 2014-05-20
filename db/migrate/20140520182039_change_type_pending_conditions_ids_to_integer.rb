class ChangeTypePendingConditionsIdsToInteger < ActiveRecord::Migration
  def change
  	remove_column :pending_conditions, :horse_id
  	remove_column :pending_conditions, :condition_id
  	add_column :pending_conditions, :horse_id, :integer
  	add_column :pending_conditions, :condition_id, :integer
  end
end
