class AddTelToDays < ActiveRecord::Migration
  def change
  	add_column :days, :tel_id, :integer
  end
end
