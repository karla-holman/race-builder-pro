class HorseCondition < ActiveRecord::Base	
	belongs_to :horse
	belongs_to :condition
end
