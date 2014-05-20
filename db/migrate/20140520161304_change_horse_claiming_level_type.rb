class ChangeHorseClaimingLevelType < ActiveRecord::Migration
  def change
  	remove_column :horses, :last_claiming_level
  	add_column :horses, :last_claiming_level, :decimal
  end
end
