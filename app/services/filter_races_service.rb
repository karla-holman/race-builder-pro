class FilterRacesService
	def horseFilter(horse)
		filtered_races = []
		@gender_category = Category.find_by_name("Gender")
		@bred_category = Category.find_by_name("Bred")

		Race.where(:status => "Published").each do |race|
			@remove = false
			@gender = true
			@bred = true

			if race.conditions.where(:category_id => @gender_category.id).any?
				@gender = false
			elsif race.conditions.where(:category_id => @bred_category.id).any?
				@bred = false
			end

			race.conditions.each do |condition|
        category = condition.category
        case category.name
        when 'Age'
          if !filter_range(condition, age(horse.birth_year))
          	@remove = true
          end
        when 'Wins'
          if !filter_range(condition, horse.wins)
          	@remove = true
          end
        when 'Gender'
          if horse.gender == condition.value
          	@gender = true
          end
        when 'Bred'
          if condition.value == horse.POB
            @bred = true
          end 
        when 'Hasn\'t Won Since'
          if condition.value.to_i > @horse.last_win.year
            @remove = true
          end
        end
        if @remove
        	next
        end
      end
      if !@remove && @gender && @bred
      	filtered_races.push(race)
      end
		end
		return filtered_races
	end


  def conditionFilter(races, condition)
  	filtered_races = []
  	category = condition.category

  	races.each do |race|
  		conditions = race.conditions.where(:category_id => category.id)
  		if conditions.empty?
  			filtered_races.push(race)
  			next
  		end

      checkCondition = conditions.first

  		if checkCondition == condition 
  			filtered_races.push(race)
  		end
  	end
  	return filtered_races
  end

  def genderFilter(races, condition)
    filtered_races = []
    category = Category.find_by_name("Gender")

    races.each do |race|
      conditions = race.conditions.where(:category_id => category.id)
      if conditions.empty?
        filtered_races.push(race)
        next
      end

      conditions.each do |genderCondition|
        if genderCondition == condition
          filtered_races.push(race)
        end
      end
    end
    return filtered_races
  end

  def distanceFilter(races, distance)
    filtered_races = []

    races.each do |race|
      if distance == "Long" && race.distance_type == "Miles"
        filtered_races.push(race)
      elsif distance == "Short" && race.distance_type == "Furlongs"
        filtered_races.push(race)
      end
    end
    return filtered_races
  end
  
  def age(dob)
    now = Time.now.utc.to_date
    return now.year - dob
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
