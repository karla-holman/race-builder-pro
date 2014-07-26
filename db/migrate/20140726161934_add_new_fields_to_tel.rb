class AddNewFieldsToTel < ActiveRecord::Migration
  def change
  	add_column :tels, :weekend_start, :datetime
  end
end
