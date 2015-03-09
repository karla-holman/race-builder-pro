class FilterRacesService
  def winCategories(horse)
    @conditions = []
    Condition.where(:category_id => Category.find_by_name("Wins")).each do |condition|
      if horse.satisfiesCondition(condition)
        @conditions.push(condition)
      end
    end
    return @conditions
  end

  def ageCategories(horse)
    @conditions = []
    Condition.where(:category_id => Category.find_by_name("Age")).each do |condition|
      if filter_range(condition, age(horse.birth_year))
        @conditions.push(condition)
      end
    end
    return @conditions
  end

  def bredCategories(horse)
    @conditions = []
    Condition.where(:category_id => Category.find_by_name("Restriction")).each do |condition|
      if horse.satisfiesCondition(condition)
        @conditions.push(condition)
      end
    end
    return @conditions
  end

	def horseFilter(horse)
    filtered_races = []

    FilterRacesService.new.currentEligibleRaces().each do |race|
      if race.isHorseEligible(horse)
        filtered_races.push(race)
      end
    end
    return filtered_races
	end


  def conditionFilter(races, condition)
  	filtered_races = []
  	races.each do |race|
  		if race.includesCondition(condition)
        filtered_races.push(race)
      end
  	end
  	return filtered_races
  end

  def sexFilter(races, condition)
    filtered_races = []

    if condition == 'F/M'
      sex_one = Condition.find_by_name("F")
      sex_two = Condition.find_by_name("M") 
    elsif condition == 'C/G'
      sex_one = Condition.find_by_name("C")
      sex_two = Condition.find_by_name("G")
    end

    if sex_one && sex_two
      races.each do |race|
        if race.includesCondition(sex_one)
          filtered_races.push(race)
        elsif race.includesCondition(sex_two)
          filtered_races.push(race)
        end
      end
    else
      races.each do |race|
        if race.includesCondition(condition)
          filtered_races.push(race)
        end
      end
    end

    return filtered_races
  end

  def distanceFilter(races, distance)
    filtered_races = []

    races.each do |race|
      if race.distance 
        if distance == "Long"
          if race.distance_type == "Miles" && race.distance >= 1
            filtered_races.push(race)
          elsif race.distance_type == "Furlongs" && race.distance >= 8
            filtered_races.push(race)
          end
        elsif distance == "Short"
          if race.distance_type == "Miles" && race.distance < 1
            filtered_races.push(race)
          elsif race.distance_type == "Furlongs" && race.distance < 8
            filtered_races.push(race)
          end
        end
      end
    end
    return filtered_races
  end

  def lowerClaimingFilter(races, purse)
    filtered_races = []

    races.each do |race|
      race.claiming_prices.each do |claiming|
        if claiming.price
          if claiming.price >= purse.to_i
            filtered_races.push(race)
            break
          end
        end
      end
    end
    return filtered_races
  end

  def upperClaimingFilter(races, purse)
    filtered_races = []

    races.each do |race|
      race.claiming_prices.each do |claiming|
        if claiming.price
          if claiming.price <= purse.to_i
            filtered_races.push(race)
            break
          end
        end
      end
    end
    return filtered_races
  end

  def currentEligibleRaces()
    races = Race.where(:status => 'Published').to_a
    
    tels = Tel.where('entry_list = ? AND date >= ?', true, Date.today).order('date DESC')

    if !tels
      return races
    end

    tels.each do |tel|
      tel.races.each do |race|
        races.delete(race)
      end
    end

    return races
  end

  def eligibleRacesForWeek(week_id)
    races = Race.where(:status => 'Published').to_a

    week = Week.find(week_id)

    tels = week.tels
    
    if !tels
      return races
    end

    tels.each do |tel|
      tel.races.each do |race|
        races.delete(race)
      end
    end

    return races
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
