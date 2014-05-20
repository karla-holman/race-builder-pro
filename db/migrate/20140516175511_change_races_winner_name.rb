class ChangeRacesWinnerName < ActiveRecord::Migration
  def change
  	rename_column :races, :winnner, :winner
  end
end
