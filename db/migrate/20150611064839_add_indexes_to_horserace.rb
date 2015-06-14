class AddIndexesToHorserace < ActiveRecord::Migration
  def change
  	add_index :horseraces, :status
  	add_index :horseraces, :horse_id
  	add_index :horseraces, :race_id
  end
end
