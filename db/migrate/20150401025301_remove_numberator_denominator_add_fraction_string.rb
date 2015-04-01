class RemoveNumberatorDenominatorAddFractionString < ActiveRecord::Migration
  def change
  	remove_column :race_distances, :numerator, :integer
  	remove_column :race_distances, :denominator, :interger
  	add_column :race_distances, :fraction_string, :string
  end
end
