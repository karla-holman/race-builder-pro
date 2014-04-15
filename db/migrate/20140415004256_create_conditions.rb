class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.string :name
      t.integer :condition_category_id

      t.timestamps
    end
  end
end
