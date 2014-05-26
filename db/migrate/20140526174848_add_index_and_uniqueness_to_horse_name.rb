class AddIndexAndUniquenessToHorseName < ActiveRecord::Migration
  def change
  	add_index :horses, :name, :unique => true
  end
end
