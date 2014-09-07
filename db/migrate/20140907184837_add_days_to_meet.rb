class AddDaysToMeet < ActiveRecord::Migration
  def change
  	add_column :meets, :race_days, :integer
  end
end
