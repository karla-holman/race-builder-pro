class AddIsStakesToRaces < ActiveRecord::Migration
  def change
  	add_column :races, :stakes, :boolean, :default => false
  end
end
