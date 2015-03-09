class AddFilterIdToHorse < ActiveRecord::Migration
  def change
  	add_column :horses, :horse_filter_setting_id, :integer
  end
end
