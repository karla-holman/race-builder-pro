class ChangeTypeName < ActiveRecord::Migration
  def change
  	rename_column :condition_nodes, :type, :node_type
  end
end
