class UpdateRacesNewSchema < ActiveRecord::Migration
  def change
  	remove_column :races, :race_number, :integer
  	remove_column :races, :race_datetime, :datetime
  	remove_column :races, :claiming_purse, :decimal
  	remove_column :races, :claiming_level, :decimal
  	add_column :races, :category, :string
  	rename_column :races, :race_type, :type
  end
end
