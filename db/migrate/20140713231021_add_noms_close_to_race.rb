class AddNomsCloseToRace < ActiveRecord::Migration
  def change
  	add_column :races, :close_date, :datetime
  end
end
