class Remove < ActiveRecord::Migration
  def change
  	remove_column :tels, :race_id, :integer
  	remove_column :tels, :section, :string
  	remove_column :tels, :day, :string
  end
end
