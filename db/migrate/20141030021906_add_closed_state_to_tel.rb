class AddClosedStateToTel < ActiveRecord::Migration
  def change
  	add_column :tels, :closed, :boolean, :default => false
  end
end
