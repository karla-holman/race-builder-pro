class RemoveValueFromHorseStatuses < ActiveRecord::Migration
  def change
  	remove_column :horse_statuses, :value, :boolean
  end
end
