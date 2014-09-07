class AddWeekRunningToHorse < ActiveRecord::Migration
  def change
  	add_column :horses, :week_running, :integer
  end
end
