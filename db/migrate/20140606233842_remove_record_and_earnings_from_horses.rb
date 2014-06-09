class RemoveRecordAndEarningsFromHorses < ActiveRecord::Migration
  def change
  	remove_column :horses, :seconds, :integer
  	remove_column :horses, :thirds, :integer
  	remove_column :horses, :earnings, :decimal
  	add_column :horses, :URL, :string
  end
end
