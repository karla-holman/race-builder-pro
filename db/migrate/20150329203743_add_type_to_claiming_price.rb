class AddTypeToClaimingPrice < ActiveRecord::Migration
  def change
  	add_column :claiming_prices, :lower, :boolean
  end
end
