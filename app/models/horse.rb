class Horse < ActiveRecord::Base
	include PublicActivity::Common

	belongs_to :status
	belongs_to :last_win

	has_many :horseraces
	has_many :races, :through => :horseraces

	has_many :horse_equipments
	has_many :equipment, :through => :horse_equipments

	has_many :horse_meets
	has_many :meets, :through => :horse_meets

	has_many :race_winners

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
          if filter_range(condition, self.wins)
          	return true
          end
        when 'Sex'
          if self.sex == condition.value
          	return true
          end
        when 'Bred'
          if condition.value == self.POB
            return true
          end 
        when 'Hasn\'t Won Since'
          if self.last_win.date
            if condition.value.to_i >= self.last_win.date.year
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
end
