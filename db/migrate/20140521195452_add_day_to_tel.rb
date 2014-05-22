class AddDayToTel < ActiveRecord::Migration
  def change
  	add_column :tels, :day, :string
  end
end
