class AddColumnsLastwinLastclaimingvalueToHorses < ActiveRecord::Migration
  def change
  	add_column :horses, :last_win, :date
  	add_column :horses, :last_claiming_level, :string
  end
end
