class AddFieldsToHorse < ActiveRecord::Migration
  def change
  	add_column :horses, :gender, :string
  	add_column :horses, :DOB, :date
  	add_column :horses, :birth_place, :string
  	add_column :horses, :starts, :integer
  	add_column :horses, :firsts, :integer
  	add_column :horses, :seconds, :integer
  	add_column :horses, :thirds, :integer
  	add_column :horses, :earnings, :decimal, precision: 8, scale: 2
  	add_column :horses, :owner_id, :integer
  	add_column :horses, :trainer_id, :integer
  end
end
