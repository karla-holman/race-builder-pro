class AddPurseToRaces < ActiveRecord::Migration
  def change
  	add_column :races, :purse, :decimal
  end
end
