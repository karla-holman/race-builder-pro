class AddNameRequiredToEquipment < ActiveRecord::Migration
  def change
  	add_column :equipment, :name, :string
  	add_column :equipment, :required, :boolean
  end
end
