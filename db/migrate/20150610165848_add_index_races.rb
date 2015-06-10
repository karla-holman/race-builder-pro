class AddIndexRaces < ActiveRecord::Migration
  def change
    add_index :races, :status
    add_index :races, :category
  end
end
