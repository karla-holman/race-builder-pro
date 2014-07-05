class AddDistanceToRaces < ActiveRecord::Migration
  def change
  	add_column :races, :distance, :integer
  end
end
