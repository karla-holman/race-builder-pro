class CreateConditionNodes < ActiveRecord::Migration
  def change
    create_table :condition_nodes do |t|
      t.integer :parent_id
      t.integer :type
      t.integer :value
      t.timestamps
    end
  end
end
