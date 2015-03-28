class CreateNominationCloseDates < ActiveRecord::Migration
  def change
    create_table :nomination_close_dates do |t|
      t.date :date
      t.integer :race_id
      t.timestamps
    end
  end
end
