class RemoveRunningFromHorses < ActiveRecord::Migration
  def change
  	remove_column :horses, :week_running, :integer
  end
end
