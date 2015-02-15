class ChangePurseToInteger < ActiveRecord::Migration
  def change
  	change_column :races, :purse, :integer
  end
end
