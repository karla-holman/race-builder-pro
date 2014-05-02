class Condition < ActiveRecord::Base
	belongs_to :category
	has_many :horses, :through => :horse_conditions
	has_many :races, :through => :raceconditions
end
