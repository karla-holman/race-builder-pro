class RemoveCloseDateFromRaces < ActiveRecord::Migration
  def change
  	remove_column :races, :close_date, :datetime
  end
end
