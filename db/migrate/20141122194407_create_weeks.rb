class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
    	t.datetime :start_date
      	t.datetime :end_date
      	t.integer  :week_number
      	t.integer  :meet_id
      	t.timestamps
    end
  end
end
