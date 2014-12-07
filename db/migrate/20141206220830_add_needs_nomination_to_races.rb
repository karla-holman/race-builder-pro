class AddNeedsNominationToRaces < ActiveRecord::Migration
  def change
  	add_column :races, :needs_nomination, :boolean, :default => false
  end
end
