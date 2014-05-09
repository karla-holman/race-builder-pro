class AddStatuToHorserace < ActiveRecord::Migration
  def change
  	add_column :horseraces, :status, :string
  end
end
