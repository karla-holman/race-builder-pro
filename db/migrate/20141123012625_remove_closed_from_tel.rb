class RemoveClosedFromTel < ActiveRecord::Migration
  def change
  	remove_column :tels, :close, :boolean
  end
end
