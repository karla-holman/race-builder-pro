class AddDescriptionToRaces < ActiveRecord::Migration
  def change
    add_column :races, :description, :string
  end
end
