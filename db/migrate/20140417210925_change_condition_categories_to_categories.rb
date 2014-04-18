class ChangeConditionCategoriesToCategories < ActiveRecord::Migration
  def change
  	rename_table :condition_categories, :categories
  end
end
