class RemovePobFromHorsesAddCountryCodeSubregionCode < ActiveRecord::Migration
  def change
  	remove_column :horses, :POB, :string
  	remove_column :horses, :birth_place, :string

  	add_column :horses, :country_code, :string
  	add_column :horses, :subregion_code, :string
  end
end
