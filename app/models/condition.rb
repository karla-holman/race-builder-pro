class Condition < ActiveRecord::Base
	belongs_to :category
	has_many :horses, :through => :horseconditions
	has_many :races, :through => :raceconditions
end
