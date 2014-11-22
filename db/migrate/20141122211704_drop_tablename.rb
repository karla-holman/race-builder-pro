class DropTablename < ActiveRecord::Migration
  def change
  	drop_table :tels
  	drop_table :horse_conditions
  end
end
