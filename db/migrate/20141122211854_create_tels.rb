class CreateTels < ActiveRecord::Migration
  def change
    create_table :tels do |t|
    	t.date :date
		t.integer :num_races
		t.integer :week_id
		t.boolean :published, :default=> false
		t.boolean :close, :default=> false
      	t.timestamps
    end
  end
end
