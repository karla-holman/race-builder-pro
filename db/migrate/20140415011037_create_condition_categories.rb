class CreateConditionCategories < ActiveRecord::Migration
  def change
    create_table :condition_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
