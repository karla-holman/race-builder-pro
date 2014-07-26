class AddMeetIdToTel < ActiveRecord::Migration
  def change
  	add_column :tels, :meet_id, :integer
  end
end
