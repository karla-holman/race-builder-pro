class AddFieldSizeToRaces < ActiveRecord::Migration
  def change
  	add_column :races, :field_size, :integer
  end
end
