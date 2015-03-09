class RenameBredToBredId < ActiveRecord::Migration
  def change
  	rename_column :horse_filter_settings, :bred, :bred_id
  end
end
