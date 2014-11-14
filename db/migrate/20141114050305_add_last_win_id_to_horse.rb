class AddLastWinIdToHorse < ActiveRecord::Migration
  def change
  	add_column :horses, :last_win_id, :integer
  end
end
