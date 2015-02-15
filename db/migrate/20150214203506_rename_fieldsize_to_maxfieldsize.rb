class RenameFieldsizeToMaxfieldsize < ActiveRecord::Migration
  def change
  	rename_column :races, :field_size, :max_field_size
  end
end
