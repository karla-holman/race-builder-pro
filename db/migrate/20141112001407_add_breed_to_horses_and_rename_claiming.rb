class AddBreedToHorsesAndRenameClaiming < ActiveRecord::Migration
  def change
  	rename_column :horses, :last_claiming_level, :last_claiming_price
  	add_column :horses, :breed, :string
  end
end
