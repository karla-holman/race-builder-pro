class Add < ActiveRecord::Migration
  def change
  	add_column :conditions, :needsDate, :boolean
  end
end
