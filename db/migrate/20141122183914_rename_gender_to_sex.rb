class RenameGenderToSex < ActiveRecord::Migration
  def change
  	rename_column :horses, :gender, :sex
  end
end
