class ChangeMeetTypes < ActiveRecord::Migration
  def change
  	remove_column :meets, :start_date, :integer
  	remove_column :meets, :end_date, :integer
  end
end
