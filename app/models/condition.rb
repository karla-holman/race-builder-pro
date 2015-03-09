class Condition < ActiveRecord::Base
	belongs_to :category
	
	has_many :races, :through => :raceconditions


	def parsedName
		if self.category.name == "Restriction"
			split = self.name.split(',')
			return split[0]
		else
			return self.name
		end
	end

	def categoryAndName
		if self.category.name == "Restriction"
			split = self.name.split(',')
			name = split[0]
		else
			name = self.name
		end


    	"#{self.category.name} - #{name}"
  	end
end
