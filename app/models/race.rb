class Race < ActiveRecord::Base
	include PublicActivity::Common
	
	has_many :horseraces
	has_many :horses, :through => :horseraces, :dependent => :destroy

	has_many :race_winners, :dependent => :destroy

	has_many :race_conditions, :dependent => :destroy
	has_many :conditions, :through => :race_conditions, :dependent => :destroy

	belongs_to :tel

	belongs_to :condition_node

	has_one :race_date, :dependent => :destroy
	has_one :race_distance, :dependent => :destroy
	has_one :nomination_close_date, :dependent => :destroy

	has_many :claiming_prices, :dependent => :destroy
	def self.search(query)
  		where("lower(name) like ?", "%#{query}%".downcase)
	end

	def distance
		if !self.race_distance
			return 'N/A'
		else
			string = ''

			if self.race_distance.distance
				string += self.race_distance.distance.to_s
			else return 'N/A'
			end

			if !(self.race_distance.numerator == 1 && self.race_distance.denominator == 1)
				string += ' '+self.race_distance.numerator.to_s+'/'+self.race_distance.denominator.to_s
			end

			string += self.race_distance.distance_type

			if self.race_distance.yards
				string += ' '+self.race_distance.yards.to_s+'Y'
			end

			return string
		end
	end

	def interested_count
		return self.horseraces.where(:status => "Interested").count
	end

	def confirmed_count
		return self.horseraces.where(:status => "Confirmed").count
	end

	def distance_sort_value
		if !self.race_distance || !self.race_distance.distance
			return 0
		end

		if self.race_distance.distance_type == 'Y'
			return 1000000+self.race_distance.distance
		elsif self.race_distance.distance_type == 'F'
			return 2000000+self.race_distance.distance
		elsif  self.race_distance.distance_type == 'M'
			if self.race_distance.yards
				return 3000000+(10000+ self.race_distance.yards)
			elsif !(self.race_distance.numerator == 1 && self.race_distance.denominator == 1)
				return 3000000+(1000+ self.race_distance.numerator/self.race_distance.denominator)
			else
				return 3000000+(100000+self.race_distance.distance)
			end
		else
			return 0
		end
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

	def includesWins
		if self.condition_node
			return self.condition_node.includesWins
		else
			return false
		end
	end

	def getSexConditions
		if self.condition_node
			return self.condition_node.getSexConditions.uniq
		else
			return []
		end
	end

	def getAgeConditions
		if self.condition_node
			return self.condition_node.getAgeConditions.uniq
		else
			return []
		end
	end

	def getExpressionString
		if self.condition_node
			return self.condition_node.getExpressionString
		else
			return "No Conditions"
		end 
	end

	def isClaiming
		if self.race_type == "Claiming" || self.race_type == "Allowance Optional Claiming" || self.race_type == "Maiden Claiming" || self.race_type == "Maiden Optional Claiming"
			return true
		else
			return false
		end
	end


	def cloneConditions(race)
		if !race.condition_node
			return
		end

		new_node = race.condition_node.dup
		new_node.value = self.id
		new_node.save

		race.condition_node.children.each do |child|
			new_child = child.dup
			new_child.parent_id = new_node.id
			new_child.save

			new_node.children.push(new_child)

			cloneChildren(new_child, child)
		end

		new_node.save
		self.condition_node = new_node
	end

	def cloneChildren (new_node, old_node)
		old_node.children.each do |child|
			new_child = child.dup
			new_child.parent_id = new_node.id
			new_child.save

			new_node.children.push(new_child)

			cloneChildren(new_child, child)
		end

		new_node.save
	end

	def duplicateRace
	    new_race = self.dup
	    new_race.save

	    if self.race_distance
		    new_distance = self.race_distance.dup
		    new_distance.race_id = new_race.id
		    new_distance.save
		    new_race.race_distance = new_distance
        end
	    if self.claiming_prices[0]
	      new_claiming = self.claiming_prices[0].dup
	      new_claiming.race_id = new_race.id
	      new_claiming.save
	      new_race.claiming_prices[0] = new_claiming
	    end

	    if self.claiming_prices[1]
	      new_claiming = self.claiming_prices[1].dup
	      new_claiming.race_id = new_race.id
	      new_claiming.save
	      new_race.claiming_prices[1] = new_claiming
	    end

	    if self.race_date && self.race_date.date
            @race_date = RaceDate.new
            @race_date.race_id = new_race.id        
            @race_date.date = self.race_date.date
            @race_date.save
            new_race.race_date = @race_date
          end
          if self.nomination_close_date && self.nomination_close_date.date
            @race_date = NominationCloseDate.new
            @race_date.race_id = new_race.id        
            @race_date.date = self.race_date.date
            @race_date.save
            new_race.nomination_close_date = @race_date
          end

	    new_race.cloneConditions(self)

	    if new_race.race_date && new_race.race_date.date && new_race.status == "Published"
	      tel = Tel.where(:date => new_race.race_date.date).first
	      new_race.tel = tel
	    else
	      new_race.tel = nil
	    end 

	    new_race.save
	end
end
