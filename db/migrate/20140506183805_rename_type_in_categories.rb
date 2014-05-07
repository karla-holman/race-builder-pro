class RenameTypeInCategories < ActiveRecord::Migration
  def change
  	rename_column :categories, :type, :datatype
  end
end
