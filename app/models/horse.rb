class Horse < ActiveRecord::Base
	include PublicActivity::Common

	belongs_to :status
	belongs_to :last_win
	belongs_to :horse_filter_setting

	has_many :horseraces, :dependent => :destroy
	has_many :races, :through => :horseraces

	has_many :horse_equipments
	has_many :equipment, :through => :horse_equipments, :dependent => :destroy

	has_many :horse_meets
	has_many :meets, :through => :horse_meets, :dependent => :destroy

	has_many :race_winners, :dependent => :destroy



	belongs_to :owner, class_name: 'User'
	belongs_to :trainer, class_name: 'User'

	def self.search(query)
  		where("lower(name) like ?", "%#{query}%".downcase)
	end

	def age
		now = Time.now.utc.to_date
    	return now.year - self.birth_year
	end

	def satisfiesCondition(condition)
		category = condition.category
        case category.name
        when 'Age'
          if filter_range(condition, self.age)
          	return true
          end
        when 'Wins'
        	if condition.value && !condition.value.empty?
        		wins = getWinsSince(condition.value, self)
        	else
        		wins = self.wins
        	end
      		if filter_range(condition, wins)
      			return true
      		end
        when 'Sex'
          if self.sex == condition.value
          	return true
          end
        when 'Restriction'
        	split = condition.value.split(',')

        	if !split[0].nil? && !split[1].nil?
        		sub_code = split[0].strip
        		country_code = split[1].strip
        		
        		if self.country_code == country_code && self.subregion_code == sub_code
        			return true
        		end
        	end
        end
        return false
	end

	def filter_range(condition, value)
	    if condition.lowerbound.nil?
	      if value > condition.upperbound
	        return false
	      else
	        return true
	      end
	    elsif condition.upperbound.nil?
	      if value < condition.lowerbound
	        return false
	      else
	        return true
	      end
	    else
	      if condition.upperbound < value || value < condition.lowerbound
	        return false
	      else
	        return true
	      end
	    end
  	end

  	def getWinsSince(dateString, horse)
  		date = dateString.to_date
  		race_wins = horse.race_winners.where('date >= ?', date)
  		race_wins = race_wins.count
  		if race_wins <= 0
  			if horse.last_win && !horse.last_win.date.nil? && !date.nil?
  				if horse.last_win.date >= date
  					race_wins = 1
  				end 
  			end
  		end

  		return race_wins
  	end
end
