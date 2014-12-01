class CreateClaimingPrices < ActiveRecord::Migration
  def change
    create_table :claiming_prices do |t|
      t.decimal :price
      t.integer :race_id
      t.timestamps
    end
  end
end
