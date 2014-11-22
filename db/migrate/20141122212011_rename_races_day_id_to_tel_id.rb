class RenameRacesDayIdToTelId < ActiveRecord::Migration
  def change
  	rename_column :races, :day_id, :tel_id
  end
end
