class Condition < ActiveRecord::Base
	belongs_to :category
	
	has_many :races, :through => :raceconditions



	def categoryAndName
    	"#{self.category.name} - #{self.name}"
  	end
end
