class CreateTels < ActiveRecord::Migration
  def change
    create_table :tels do |t|
    	t.integer :race_id
    	t.integer :level
    	t.string :section
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
