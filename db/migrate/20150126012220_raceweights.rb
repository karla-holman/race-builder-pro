class Raceweights < ActiveRecord::Migration
  def change
  	add_column :races, :weights, :string
  end
end
