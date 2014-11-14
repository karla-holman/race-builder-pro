class RemoveLastWinFromHorse < ActiveRecord::Migration
  def change
  	remove_column :horses, :last_win, :datetime
  end
end
