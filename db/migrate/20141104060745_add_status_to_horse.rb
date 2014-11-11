class AddStatusToHorse < ActiveRecord::Migration
  def change
  	add_column :horses, :status_id, :integer
  end
end
