class RemoveLevelFromTel < ActiveRecord::Migration
  def change
  	remove_column :tels, :level, :string
  end
end
