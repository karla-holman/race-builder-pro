class AddColumnsPendingConditions < ActiveRecord::Migration
	def change
		add_column :pending_conditions, :horsecondition_id, :integer
		add_column :pending_conditions, :action, :string
	end
end
