class AddPublishedToTel < ActiveRecord::Migration
  def change
  	add_column :tels, :published, :boolean, :default => false
  end
end
