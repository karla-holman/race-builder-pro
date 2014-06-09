class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.integer :send_id
    	t.integer :recv_id
    	t.string :action
    	t.datetime :created_at
      t.datetime :updated_at
      t.timestamps
    end
  end
end
