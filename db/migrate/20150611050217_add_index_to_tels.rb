class AddIndexToTels < ActiveRecord::Migration
  def change
  	add_index :tels, :entry_list
  end
end
