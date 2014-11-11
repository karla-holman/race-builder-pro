class DropHorseStatusesTable < ActiveRecord::Migration
  def change
  	drop_table :horse_statuses
  end
end
