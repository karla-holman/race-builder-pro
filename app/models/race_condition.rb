class RaceCondition < ActiveRecord::Base
	belongs_to :race
	belongs_to :condition
end
