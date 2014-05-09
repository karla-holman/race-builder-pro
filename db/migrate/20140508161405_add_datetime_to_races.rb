class AddDatetimeToRaces < ActiveRecord::Migration
  def change
  	add_column :races, :race_datetime, :datetime
  end
end
