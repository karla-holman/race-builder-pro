class Tel < ActiveRecord::Base
	has_many :races
	belongs_to :week

	def long_date
  		date.strftime('%a %b %d, %Y')
	end

	def purse_total
		purse_total = 0

		races.each do |race|
      		purse_total += race.purse
    	end

    	return purse_total
	end

	def average_field_size
		average_field_size = 0
		num_races = 0

	    races.each do |race|
	      if race.horseraces
	        average_field_size += race.horseraces.where(:status => "Confirmed").count
	        num_races = num_races + 1
	      end
	    end

	    if num_races > 0
	      average_field_size = average_field_size/num_races
	    end

	    return average_field_size
	end
end
