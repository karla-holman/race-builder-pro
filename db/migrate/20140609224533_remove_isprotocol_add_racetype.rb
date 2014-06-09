class RemoveIsprotocolAddRacetype < ActiveRecord::Migration
  def change
  	remove_column :races, :is_protocol, :boolean
  	add_column :races, :race_type, :string
  end
end
