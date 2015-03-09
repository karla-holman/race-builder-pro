class AddOtherConditionFlagToRace < ActiveRecord::Migration
  def change
  	add_column :races, :hasOtherConditions, :boolean
  end
end
