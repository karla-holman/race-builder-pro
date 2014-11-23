class ChangeDatetimeToDateLastWins < ActiveRecord::Migration
  def change
  	change_column :last_wins, :date, :date
  end
end
