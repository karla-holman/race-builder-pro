class Race < ActiveRecord::Base
	include PublicActivity::Common
	
	has_many :horseraces
	has_many :horses, :through => :horseraces

	has_many :race_winners

	has_many :race_conditions
	has_many :conditions, :through => :race_conditions

	belongs_to :tel

	belongs_to :condition_node

	has_one :race_date

	has_many :claiming_prices

	def self.search(query)
  		where("lower(name) like ?", "%#{query}%".downcase)
	end

	def isHorseEligible(horse)
		if self.condition_node
			return self.condition_node.isHorseEligible(horse)
		else
			return true
		end
	end

	def includesCondition(condition)
		if self.condition_node
			return self.condition_node.includesCondition(condition)
		else
			return false
		end
	end
end
