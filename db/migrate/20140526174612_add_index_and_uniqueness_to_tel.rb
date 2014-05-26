class AddIndexAndUniquenessToTel < ActiveRecord::Migration
  def change
  	add_index :tels, :race_id, :unique => true
  end
end
