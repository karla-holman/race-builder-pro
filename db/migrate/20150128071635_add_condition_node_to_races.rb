class AddConditionNodeToRaces < ActiveRecord::Migration
  def change
  	add_column :races, :condition_node_id, :integer
  end
end
