class ChangeDistanceToDecimal < ActiveRecord::Migration
  def change
  	change_column :last_wins, :distance, :decimal
  end
end
