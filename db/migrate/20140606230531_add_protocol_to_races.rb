class AddProtocolToRaces < ActiveRecord::Migration
  def change
  	add_column :races, :is_protocol, :boolean
  end
end
