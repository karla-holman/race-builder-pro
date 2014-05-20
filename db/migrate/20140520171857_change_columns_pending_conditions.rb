class ChangeColumnsPendingConditions < ActiveRecord::Migration
  def change
  	remove_column :pending_conditions, :horsecondition_id
  	add_column :pending_conditions, :horse_id, :decimal
  	add_column :pending_conditions, :condition_id, :decimal
  end
end
