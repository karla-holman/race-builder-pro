class UghAddColumnsCauseOfStupidTimezone < ActiveRecord::Migration
  def change
  	add_column :meets, :start_date, :datetime
  	add_column :meets, :end_date, :datetime
  end
end
