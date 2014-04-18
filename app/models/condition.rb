class Condition < ActiveRecord::Base
	belongs_to :category
	has_many :horses, :through => :horseconditions
end
