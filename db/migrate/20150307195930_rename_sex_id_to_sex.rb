class RenameSexIdToSex < ActiveRecord::Migration
  def change
  	rename_column :horse_filter_settings, :sex_id, :sex
  end
end
