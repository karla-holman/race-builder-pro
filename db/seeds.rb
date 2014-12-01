# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
trainer = CreateTrainerService.new.call
owner = CreateOwnerService.new.call

puts 'CREATED ADMIN USER: ' << user.email
puts 'CREATED TRAINER: ' << trainer.email
puts 'CREATED OWNER: ' << owner.email

#Category Hash Array: Category => [Conditions]
categories = Hash['Age'=>['3+', '3YO', '2YO'], 
			'Wins'=> ['Maiden', 'NW2', 'NW3'], 'Sex' => ['M', 'F', 'C', 'G', 'H', 'R'], 'Hasn\'t Won Since' => ['2012']]

equipment_medication =  ['Bute', 'First Time Lasix', 'Lasix On', 'Lasix Off', 'Blinkers', 'Cheek Piece',
						'Cornell Collar', 'Front Wraps', 'Nasal Strip']

statuses = ['Race Ready', 'Vet\'s List', 'Steward\'s List', 'Inactive']

#Races: [Name, Description, Status, Category, Distance Type, Distance, Purse, Field Size]
races = [['Alw4400NC', '3 year olds and upwards, 400 yards allowance, purse $4,400', 'Published', "Alternate",'Yards', 400, 4400, 10],
		['f Md 12500', 'maidens, fillies, two years old, purse $4,400, claiming price $12,500', 'Published', "Alternate",'Furlongs', 5.5, 4400, 12],
		['Clm 2500N3L', '3 year olds and upwards, never won three races, non-winners since June 15, purse $4,400, claiming price $2,500', 'Published', "Alternate",'Furlongs', 5.5, 4400, 6],
		['Clm 3500B', '3 year olds and upwards, have not won two races since April 12 or never won 4 races, purse $6,200, claiming price $3,500', 'Published', "Alternate",'Furlongs', 6, 7775, 8],
		['Clm 7500N3L', '3 year olds and upwards, never won three races, non-winners since June 15, purse $7,775, claiming price $7,500', 'Published', "Alternate",'Mile', 1, 7500, 10],
		['Clm 2500B', '3 year olds and upwards, never won two races since April 12 or which have never won 4 races, purse $10,700, claiming price $2,500', 'Published', "Alternate",'Furlongs', 6, 10700, 14],
		['Clm 7500', '3 year olds and upwards, non-winners since June 15, purse $9,300, claiming price $7,500', 'Published', "Alternate",'Furlongs', 5.5, 7500, 6],
		['r CahillRoad50k', 'THE NWSS CAHILL ROAD. purse $50,000 for two-year-olds, progeny of stallions standing in 2011 that have been duly nominated. stallions to be nominated
			at a fee of $500 or 50% of published stud fee by April 15, 2010. $350 to enter, $350 additional to start. 5% of gross
			NWRS monies shall be paid to the eligible nominators of the top 5 finishers. 5% of gross NWRS monies shall be
			paid to the eligible nominators of the sires of the top 3 finishers. Remaining monies to be divided 55% to the winner,
			20% to second, 15% to third, 7.5% to fourth and 2.5% to fifth. Weight 120 lbs.; Maidens allowed 2 lbs. In the event
			more than 12 entries are received, preference in the draw for post positions will be based on money earned.
			Starters to be named through the entry box by the closing time of entries. The conditions of this race may be
			changed with the consent of the Washington Thoroughbred Breeders and Owners Association. See condition book
			for a breakdown of The Northwest Race Series. STALLION NOMINATIONS CLOSED. Supplementary
			nomination may be made at entry time at a cost of $2,500 (Stallion must be eligible)',
			'Published', "Priority",'Furlongs', 6, 50000, 6],
		['GottstnFut65k', 'THE GOTTSTEIN FUTURITY. Purse $65,000 (includes $12,500 Other Sources) For
			Two-year-olds (Foals Of 2012). $500 to enter, $500 additional to start. 5% of NWRS gross monies shall be paid to
			the eligible nominators of the top 5 finishers. 5% of NWRS gross monies shall be paid to the eligible nominators of
			the top 3 finishers with remaining monies to be divided 55% to the winner, 20% to second, 15% to third, 7.5% to
			fourth and 2.5% to fifth. Weight 120 lbs., Fillies 117 lbs. In the event more than 12 entries are received, preference in
			the draw for post poisitions will be based on money earned. Starters to be named through the entry box by the
			closing time of entries. The conditions of this race may be changed with the consent of the Washington
			Thoroughbred Breeders and Owners Association. See condition book for a breakdown ofThe Northwest Race
			Series. Limited to 12 starters. NOMINATIONS CLOSED. Supplementary nominations may be made at time of
			entry at a cost of $7,500.',
			'Published', "Priority",'Miles', 1.0625, 65000, 8],
		['f OC 50k/C', 'fillies and mares, 3 year olds and upwards, $30,000 once since april 12, 2014 Or which have never won three races or claiming price $50,000, non-winners of a race since June 15 allowed 3lbs, purse $21,000, claiming price $50,000', 'Published', "Priority",'Furlongs', 6.5, 21000],
		['Md 5000', 'maidens, 3 year olds and upwards, purse $5,500, claiming price $5,000', 'Published', "Priority",'Furlongs', 6.5, 5500, 12]]

#Horses: [Name, Breed, Country, Region, Sex, Birth Year, Starts, Wins, Last Win, Owner Email, Trainer Email, Week Running]
horses = [['Sissis Little Nipper', 'Quarter Horse', 'US', 'OR', 'G', 2010, 15, 12, '2014-9-1', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['BH Country Chrome', 'Quarter Horse', 'US', 'WA', 'C', 2011, 10, 5, '2014-6-25', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Eyes Movin', 'Quarter Horse', 'US', 'WA', 'G', 2007, 16, 12, '2014-7-6', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Mr Speedygonzalez', 'Quarter Horse', 'US', 'OR', 'G', 2010, 10, 3, '2014-7-27', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Cloudy Dasher', 'Quarter Horse', 'US', 'CA', 'F', 2011, 5, 1, '2013-5-25', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Jess Be Hawkin', 'Quarter Horse', 'US', 'WA', 'F', 2010, 8, 4, '2012-9-16', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Twelfth Fan', 'Thoroughbred', 'US', 'WA', 'F', 2012, 5, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Mystic Witch', 'Thoroughbred', 'US', 'WA', 'F', 2012, 0, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Bodacious', 'Thoroughbred', 'US', 'WA', 'F', 2012, 5, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['In Private', 'Thoroughbred', 'US', 'WA', 'F', 2012, 4, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['City Sensation', 'Thoroughbred', 'US', 'VA', 'F', 2012, 0, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Three Olives Later', 'Thoroughbred', 'US', 'WA', 'F', 2012, 4, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Charming Budha', 'Thoroughbred', 'US', 'WA', 'G', 2010, 6, 2, '2014-9-6', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Almosttoomuchfun', 'Thoroughbred', 'CA', 'ON', 'G', 2011, 8, 2, '2014-8-10', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Game Kick', 'Thoroughbred', 'US', 'AZ', 'F', 2011, 5, 2, '2014-9-20', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Moony Moony', 'Thoroughbred', 'US', 'WA', 'C', 2011, 9, 2, '2014-8-10', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Ringo\'s Gold', 'Thoroughbred', 'US', 'WA', 'G', 2007, 10, 2, '2012-5-4', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Sabe', 'Thoroughbred', 'US', 'FL', 'G', 2009, 7, 2, '2012-4-15', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Wheels of Fire', 'Thoroughbred', 'US', 'CA', 'G', 2008, 12, 10, '2014-8-29', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Sax', 'Thoroughbred', 'US', 'CA', 'G', 2006, 18, 14, '2014-8-31', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Shoer Hugh', 'Thoroughbred', 'US', 'CA', 'R', 2010, 8, 4, '2014-9-12', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Dead Eye', 'Thoroughbred', 'US', 'WA', 'G', 2009, 10, 7, '2014-9-19', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Immigration', 'Thoroughbred', 'US', 'WA', 'G', 2004, 10, 7, '2014-9-13', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Skip My Turn', 'Thoroughbred', 'US', 'WA', 'G', 2011, 5, 2, '2014-8-8', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Cheese', 'Thoroughbred', 'US', 'WA', 'F', 2010, 3, 1, '2013-5-25', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Bluegrass Fox Trot', 'Thoroughbred', 'US', 'KY', 'G', 2011, 2, 2, '2014-8-15', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Ionize', 'Thoroughbred', 'US', 'OR', 'C', 2010, 2, 1, '2014-8-8', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Regazze Cat', 'Thoroughbred', 'US', 'WA', 'G', 2011, 3, 2, '2014-9-14', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['No Claim Will Do', 'Thoroughbred', 'US', 'KY', 'G', 2011, 4, 2, '2014-8-30', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Cinnamon Mocha', 'Thoroughbred', 'US', 'KY', 'F', 2010, 2, 2, '2014-3-4', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Bones Zee', 'Thoroughbred', 'US', 'WA', 'H', 2009, 5, 2, '2013-8-23', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['He\'s Zubberific', 'Thoroughbred', 'US', 'WA', 'G', 2011, 10, 2, '2014-4-26', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Wild Hoss', 'Thoroughbred', 'US', 'WA', 'H', 2009, 10, 4, '2013-6-28', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Twist My Kazoo', 'Thoroughbred', 'US', 'CA', 'G', 2007, 8, 4, '2014-7-19', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Heza Witch Doctor', 'Thoroughbred', 'US', 'WA', 'G', 2007, 10, 6, '2014-7-3', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Salty Le Mousee', 'Thoroughbred', 'US', 'CA', 'G', 2007, 10, 6, '2014-7-6', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Secret Harbor', 'Thoroughbred', 'US', 'CA', 'G', 2011, 3, 3, '2014-6-7', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Buds a Flyin', 'Thoroughbred', 'US', 'WA', 'G', 2007, 12, 11, '2014-5-17', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Lots of Prayers', 'Thoroughbred', 'US', 'KY', 'G', 2010, 4, 3, '2014-8-23', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Advancement', 'Thoroughbred', 'US', 'KY', 'H', 2008, 5, 4, '2014-8-10', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Snooper Dauper', 'Thoroughbred', 'US', 'WA', 'H', 2009, 4, 3, '2014-5-18', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Light My Heart', 'Thoroughbred', 'US', 'WA', 'G', 2009, 5, 4, '2014-1-22', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Regal Valid', 'Thoroughbred', 'US', 'WA', 'G', 2009, 6, 3, '2014-6-8', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Mr. Top Kat', 'Thoroughbred', 'US', 'WA', 'R', 2009, 10, 9, '2014-6-29', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Financial Officer', 'Thoroughbred', 'US', 'WA', 'G', 2010, 4, 3, '2014-6-21', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Northern Poptart', 'Thoroughbred', 'US', 'ID', 'G', 2007, 10, 8, '2014-8-2', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Marvin\'s Magic', 'Thoroughbred', 'US', 'WA', 'G', 2008, 15, 12, '2014-9-5', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['War Wizard', 'Thoroughbred', 'US', 'KY', 'G', 2009, 10, 8, '2014-9-1', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Chaching Pete', 'Thoroughbred', 'US', 'WA', 'G', 2007, 13, 12, '2014-9-21', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Ugottabcatty', 'Thoroughbred', 'US', 'WA', 'G', 2006, 10, 7, '2014-8-1', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Rainier Ice', 'Thoroughbred', 'US', 'KY', 'G', 2008, 10, 8, '2014-6-20', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Brutally Handsome', 'Thoroughbred', 'US', 'FL', 'G', 2007, 5, 3, '2014-9-1', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Daytona Beach', 'Thoroughbred', 'US', 'WA', 'G', 2012, 2, 1, '2014-9-1', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Gavinator', 'Thoroughbred', 'US', 'WA', 'C', 2012, 2, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Eight Ball Parker', 'Thoroughbred', 'US', 'WA', 'G', 2012, 2, 1, '2014-7-18', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Ididn\'taskforthis', 'Thoroughbred', 'US', 'WA', 'G', 2012, 1, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Carson\'s Start', 'Thoroughbred', 'US', 'WA', 'G', 2012, 3, 1, '2014-7-13', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Moby', 'Thoroughbred', 'US', 'WA', 'G', 2012, 3, 1, '2014-8-3', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Caddy Shack Cat', 'Thoroughbred', 'US', 'WA', 'G', 2012, 1, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Prime Engine', 'Thoroughbred', 'US', 'KY', 'C', 2012, 3, 1, '2014-9-13', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Val De Saire', 'Thoroughbred', 'US', 'WA', 'F', 2012, 2, 1, '2014-9-6', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Old Fashioned Grit', 'Thoroughbred', 'US', 'KY', 'G', 2012, 3, 1, '2014-8-24', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Bolshoi\'s Bluff', 'Thoroughbred', 'US', 'WA', 'G', 2012, 2, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Trackattacker', 'Thoroughbred', 'US', 'WA', 'G', 2012, 5, 4, '2014-9-7', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Private Boss', 'Thoroughbred', 'US', 'WA', 'G', 2012, 4, 1, '2014-6-8', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Blueberry Smoothie', 'Thoroughbred', 'US', 'WA', 'F', 2011, 3, 2, '2012-9-22', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Chu and You', 'Thoroughbred', 'US', 'WA', 'F', 2011, 10, 6, '2014-9-7', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Hetty', 'Thoroughbred', 'US', 'WA', 'F', 2010, 5, 3, '2014-7-26', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Finding More', 'Thoroughbred', 'US', 'WA', 'F', 2010, 6, 4, '2013-6-20', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Timeless Pleasure', 'Thoroughbred', 'US', 'KY', 'F', 2011, 2, 1, '2014-5-25', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['I Thought So', 'Thoroughbred', 'US', 'KY', 'F', 2011, 3, 2, '2014-9-20', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Corla', 'Thoroughbred', 'US', 'WA', 'F', 2010, 2, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Tactical Strike', 'Thoroughbred', 'US', 'WA', 'C', 2011, 2, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Miners Thunder', 'Thoroughbred', 'US', 'WA', 'G', 2011, 3, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Right Idea', 'Thoroughbred', 'US', 'KY', 'G', 2011, 2, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Shadow Code', 'Thoroughbred', 'US', 'CA', 'C', 2009, 2, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Dakota Firefly', 'Thoroughbred', 'US', 'WA', 'G', 2009, 3, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com']]

new_meet = Meet.find_or_create_by!(name: 'Summer 2014', start_date: '2014-04-01 00:00:00', end_date: '2014-10-30 12:00:00', race_days: 60)
new_meet.save
meet = Meet.find_by_name('Summer 2014')
new_week = Week.find_or_create_by!(start_date: '2014-10-10', end_date: '2014-10-13', meet_id: meet.id, week_number: 1)
new_week.save

categories.each do |category, conditions|
	new_category = Category.find_or_create_by!(name: category)
	case new_category.name
	when 'Age', 'Wins'
		new_category.datatype = 'Range'
	when 'Sex', 'Bred', 'Hasn\'t Won Since'
		new_category.datatype = 'Value'
	else
		new_category.datatype = 'Bool'
	end

	if new_category.save
		puts 'CREATED CATEGORY: ' << new_category.name
	end
	conditions.each do |condition|
		new_condition = Condition.find_or_create_by!(name: condition, category_id: new_category.id)
		if new_category.name == "Sex" || new_category.name == "Bred" || new_category.name == "Hasn\'t Won Since"
			new_condition.value = condition
		end
		if new_condition.save
			puts 'CREATED CONDITION: ' << new_condition.name
		end
	end
end

statuses.each do |status|
	new_status = Status.find_or_create_by!(name: status)
	if new_status.save
		puts 'CREATED STATUS: ' << new_status.name
	end
end

equipment_medication.each do |equip|
	new_equip = Equipment.find_or_create_by!(name: equip)
	if equip == 'Blinkers'
		new_equip.required = true
	else
		new_equip.required = false
	end
	if new_equip.save
		puts 'CREATED EQUIPMENT/STATUS: ' << new_equip.name
	end
end

races.each do |race|
	new_race = Race.find_or_create_by!(name: race[0], description: race[1], status: race[2], category: race[3], distance_type: race[4], distance: race[5], purse: race[6], field_size: race[7])
	new_race.race_type = 'Default'
	if new_race.save
		puts 'CREATED RACE: ' << new_race.name
	end
end

horses.each do |horse|
	owner = User.find_by_email(horse[9])
	trainer = User.find_by_email(horse[10])
	status = Status.find_by_name('Race Ready')

	if horse[8].empty?
		horse[8] = nil
	end

	last_win = LastWin.new
	last_win.date = horse[8]
	last_win.save
	new_horse = Horse.find_or_create_by!(name: horse[0], breed: horse[1], country_code: horse[2], subregion_code: horse[3], sex: horse[4], birth_year: horse[5], starts: horse[6], 
										wins: horse[7], owner_id: owner.id, trainer_id: trainer.id, status_id: status.id)
	new_horse.last_win = last_win
	if new_horse.save
		puts 'CREATED HORSE: ' << new_horse.name
	end
end

race = Race.find_by_name('Clm 2500N3L')
race.race_type = 'Claiming'
claiming = ClaimingPrice.new
claiming.race_id = race.id
claiming.price = 2500
claiming.save
race.claiming_prices[0] = claiming
race.save

race = Race.find_by_name('Clm 3500B')
race.race_type = 'Claiming'
claiming = ClaimingPrice.new
claiming.race_id = race.id
claiming.price = 3500
claiming.save
race.claiming_prices[0] = claiming
race.save

race = Race.find_by_name('Clm 7500N3L')
race.race_type = 'Claiming'
claiming = ClaimingPrice.new
claiming.race_id = race.id
claiming.price =7500
claiming.save
race.claiming_prices[0] = claiming
race.save	

race = Race.find_by_name('Clm 2500B')
race.race_type = 'Claiming'
claiming = ClaimingPrice.new
claiming.race_id = race.id
claiming.price =2500
claiming.save
race.claiming_prices[0] = claiming
race.save	

race = Race.find_by_name('Clm 7500')
race.race_type = 'Claiming'
claiming = ClaimingPrice.new
claiming.race_id = race.id
claiming.price =7500
claiming.save
race.claiming_prices[0] = claiming
race.save


race = Race.find_by_name('r CahillRoad50k')
race.stakes = true
race.save
race = Race.find_by_name('GottstnFut65k')
race.stakes = true
race.save

threeplus = Condition.find_by_name('3+')
threeplus.lowerbound = 3
threeplus.save
three = Condition.find_by_name('3YO')
three.lowerbound = 3
three.upperbound = 3
three.save
two = Condition.find_by_name('2YO')
two.lowerbound = 2
two.upperbound = 2
two.save
maiden = Condition.find_by_name('Maiden')
maiden.lowerbound = 0
maiden.upperbound = 0
maiden.save
nwtwo = Condition.find_by_name('NW2')
nwtwo.lowerbound = 0
nwtwo.upperbound = 1
nwtwo.save
nwthree = Condition.find_by_name('NW3')
nwthree.lowerbound = 0
nwthree.upperbound = 3
nwthree.save
female = Condition.find_by_name('F')
male = Condition.find_by_name('M')

race = Race.find_by_name('Alw4400NC')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: threeplus.id)
race_condition.save

race = Race.find_by_name('f Md 12500')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: maiden.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: female.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: two.id)
race_condition.save

race = Race.find_by_name('Clm 2500N3L')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: threeplus.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: nwthree.id)
race_condition.save

race = Race.find_by_name('Clm 3500B')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: threeplus.id)
race_condition.save

race = Race.find_by_name('Clm 7500N3L')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: threeplus.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: nwthree.id)
race_condition.save

race = Race.find_by_name('Clm 2500B')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: threeplus.id)
race_condition.save

race = Race.find_by_name('Clm 7500')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: threeplus.id)
race_condition.save

race = Race.find_by_name('f OC 50k/C')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: female.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: male.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: threeplus.id)
race_condition.save

race = Race.find_by_name('Md 5000')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: maiden.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: threeplus.id)
race_condition.save













