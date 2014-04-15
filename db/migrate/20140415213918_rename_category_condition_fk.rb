class RenameCategoryConditionFk < ActiveRecord::Migration
  def change
  	rename_column :conditions, :condition_category_id, :category_id
  end
end
