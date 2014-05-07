class AddLowerUppperValueToConditions < ActiveRecord::Migration
  def change
  	add_column :conditions, :lowerbound, :integer
  	add_column :conditions, :upperbound, :integer
  	add_column :conditions, :value, :string
  end
end
