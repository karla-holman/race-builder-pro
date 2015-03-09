class ChangeSexToString < ActiveRecord::Migration
  def change
  	change_column :horse_filter_settings, :sex, :string
  end
end
