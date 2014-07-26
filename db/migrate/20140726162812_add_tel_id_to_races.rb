class AddTelIdToRaces < ActiveRecord::Migration
  def change
  	add_column :races, :tel_id, :integer
  end
end
