class ChangeColumnTypeDescriptionRacesToText < ActiveRecord::Migration
  def change
  	change_column :races, :description, :text
  end
end
