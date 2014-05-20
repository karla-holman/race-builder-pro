class CreatePendingConditions < ActiveRecord::Migration
  def change
    create_table :pending_conditions do |t|

      t.timestamps
    end
  end
end
