class AddStatusToRace < ActiveRecord::Migration
  def change
  	add_column :races, :status, :string
  end
end
