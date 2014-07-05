class RemoveWinnerAddDistanceToRaces < ActiveRecord::Migration
  def change
  	remove_column :races, :winner, :integer
  	add_column :races, :distance_type, :string
  end
end
