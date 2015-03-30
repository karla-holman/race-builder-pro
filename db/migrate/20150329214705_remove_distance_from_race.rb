class RemoveDistanceFromRace < ActiveRecord::Migration
  def change
  	remove_column :races, :distance, :integer
  	remove_column :races, :distance_type, :string
  end
end
