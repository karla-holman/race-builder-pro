class AddElStateToTel < ActiveRecord::Migration
  def change
  	add_column :tels, :entry_list, :boolean, :default => false
  end
end
