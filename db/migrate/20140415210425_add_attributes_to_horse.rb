class AddAttributesToHorse < ActiveRecord::Migration
  def change
  	add_column :horses, :POB, :string
  end
end
