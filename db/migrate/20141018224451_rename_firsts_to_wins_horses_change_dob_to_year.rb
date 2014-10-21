class RenameFirstsToWinsHorsesChangeDobToYear < ActiveRecord::Migration
  def change
  	rename_column :horses, :firsts, :wins
  	remove_column :horses, :DOB, :date
  	add_column :horses, :birth_year, :integer
  end
end
