class ChangeDistanceTypeRaces < ActiveRecord::Migration
  def change
  	change_column :races, :distance, :decimal
  end
end
