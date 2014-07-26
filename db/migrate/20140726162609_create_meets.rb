class CreateMeets < ActiveRecord::Migration
  def change
    create_table :meets do |t|
		t.integer :start_date
		t.integer :end_date
		t.string :name
      t.timestamps
    end
  end
end
