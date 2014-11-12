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
			'Wins'=> ['Maiden', 'NW2', 'NW3'], 'Gender' => ['M', 'F', 'C', 'G', 'H', 'R'], 'Bred' => ['Washington', 'Arizona', 'Virginia', 'California', 'Arizona', 'Oregon', 'Ontario-C', 'Kentucky', 'Florida', 'Idaho'], 'Hasn\'t Won Since' => ['2012']]

equipment_medication =  ['Bute', 'First Time Lasix', 'Lasix On', 'Lasix Off', 'Blinkers On', 'Cheek Piece',
						'Cornell Collar', 'Front Wraps', 'Nasal Strip']

statuses = ['Race Ready', 'Not Race Ready', 'Resting From Race', 'Vet\'s List', 'Steward\'s List', 'Inactive']

#Races: [Name, Description, Status, Category, Distance Type, Distance, Purse]
races = [['Alw4400NC', '3 year olds and upwards, 400 yards allowance, purse $4,400', 'Published', "Alternate",'Yards', 400, 4400],
		['f Md 12500', 'maidens, fillies, two years old, purse $4,400, claiming price $12,500', 'Published', "Alternate",'Furlongs', 5.5, 4400],
		['Clm 2500N3L', '3 year olds and upwards, never won three races, non-winners since June 15, purse $4,400, claiming price $2,500', 'Published', "Alternate",'Furlongs', 5.5, 4400],
		['Clm 3500B', '3 year olds and upwards, have not won two races since April 12 or never won 4 races, purse $6,200, claiming price $3,500', 'Published', "Alternate",'Furlongs', 6, 7775],
		['Clm 7500N3L', '3 year olds and upwards, never won three races, non-winners since June 15, purse $7,775, claiming price $7,500', 'Published', "Alternate",'Mile', 1, 7500],
		['Clm 2500B', '3 year olds and upwards, never won two races since April 12 or which have never won 4 races, purse $10,700, claiming price $2,500', 'Published', "Alternate",'Furlongs', 6, 10700],
		['Clm 7500', '3 year olds and upwards, non-winners since June 15, purse $9,300, claiming price $7,500', 'Published', "Alternate",'Furlongs', 5.5, 7500],
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
			'Published', "Stakes",'Furlongs', 6, 50000],
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
			'Published', "Stakes",'Miles', 1.0625, 65000],
		['f OC 50k/C', 'fillies and mares, 3 year olds and upwards, $30,000 once since april 12, 2014 Or which have never won three races or claiming price $50,000, non-winners of a race since June 15 allowed 3lbs, purse $21,000, claiming price $50,000', 'Published', "Protocol",'Furlongs', 6.5, 21000],
		['Md 5000', 'maidens, 3 year olds and upwards, purse $5,500, claiming price $5,000', 'Published', "Protocol",'Furlongs', 6.5, 5500]]

#Horses: [Name, Breed, POB, Gender, Birth Year, Starts, Wins, Last Win, Owner Email, Trainer Email, Week Running]
horses = [['Sissis Little Nipper', 'Quarter Horse', 'Oregon', 'G', 2010, 15, 12, '2014-9-1', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['BH Country Chrome', 'Quarter Horse', 'Washington', 'C', 2011, 10, 5, '2014-6-25', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Eyes Movin', 'Quarter Horse', 'Washington', 'G', 2007, 16, 12, '2014-7-6', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Mr Speedygonzalez', 'Quarter Horse', 'Oregon', 'G', 2010, 10, 3, '2014-7-27', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Cloudy Dasher', 'Quarter Horse', 'California', 'F', 2011, 5, 1, '2013-5-25', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Jess Be Hawkin', 'Quarter Horse', 'Washington', 'F', 2010, 8, 4, '2012-9-16', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Twelfth Fan', 'Thoroughbred', 'Washington', 'F', 2012, 5, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Mystic Witch', 'Thoroughbred', 'Washington', 'F', 2012, 0, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Bodacious', 'Thoroughbred', 'Washington', 'F', 2012, 5, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['In Private', 'Thoroughbred', 'Washington', 'F', 2012, 4, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['City Sensation', 'Thoroughbred', 'Virginia', 'F', 2012, 0, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Three Olives Later', 'Thoroughbred', 'Washington', 'F', 2012, 4, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Charming Budha', 'Thoroughbred', 'Washington', 'G', 2010, 6, 2, '2014-9-6', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Almosttoomuchfun', 'Thoroughbred', 'Ontario-C', 'G', 2011, 8, 2, '2014-8-10', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Game Kick', 'Thoroughbred', 'Arizona', 'F', 2011, 5, 2, '2014-9-20', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Moony Moony', 'Thoroughbred', 'Washington', 'C', 2011, 9, 2, '2014-8-10', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Ringo\'s Gold', 'Thoroughbred', 'Washington', 'G', 2007, 10, 2, '2012-5-4', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Sabe', 'Thoroughbred', 'Florida', 'G', 2009, 7, 2, '2012-4-15', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Wheels of Fire', 'Thoroughbred', 'California', 'G', 2008, 12, 10, '2014-8-29', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Sax', 'Thoroughbred', 'California', 'G', 2006, 18, 14, '2014-8-31', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Shoer Hugh', 'Thoroughbred', 'California', 'R', 2010, 8, 4, '2014-9-12', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Dead Eye', 'Thoroughbred', 'Washington', 'G', 2009, 10, 7, '2014-9-19', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Immigration', 'Thoroughbred', 'Washington', 'G', 2004, 10, 7, '2014-9-13', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Skip My Turn', 'Thoroughbred', 'Washington', 'G', 2011, 5, 2, '2014-8-8', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Cheese', 'Thoroughbred', 'Washington', 'F', 2010, 3, 1, '2013-5-25', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Bluegrass Fox Trot', 'Thoroughbred', 'Kentucky', 'G', 2011, 2, 2, '2014-8-15', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Ionize', 'Thoroughbred', 'Oregon', 'C', 2010, 2, 1, '2014-8-8', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Regazze Cat', 'Thoroughbred', 'Washington', 'G', 2011, 3, 2, '2014-9-14', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['No Claim Will Do', 'Thoroughbred', 'Kentucky', 'G', 2011, 4, 2, '2014-8-30', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Cinnamon Mocha', 'Thoroughbred', 'Kentucky', 'F', 2010, 2, 2, '2014-3-4', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Bones Zee', 'Thoroughbred', 'Washington', 'H', 2009, 5, 2, '2013-8-23', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['He\'s Zubberific', 'Thoroughbred', 'Washington', 'G', 2011, 10, 2, '2014-4-26', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Wild Hoss', 'Thoroughbred', 'Washington', 'H', 2009, 10, 4, '2013-6-28', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Twist My Kazoo', 'Thoroughbred', 'California', 'G', 2007, 8, 4, '2014-7-19', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Heza Witch Doctor', 'Thoroughbred', 'Washington', 'G', 2007, 10, 6, '2014-7-3', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Salty Le Mousee', 'Thoroughbred', 'California', 'G', 2007, 10, 6, '2014-7-6', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Secret Harbor', 'Thoroughbred', 'California', 'G', 2011, 3, 3, '2014-6-7', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Buds a Flyin', 'Thoroughbred', 'Washington', 'G', 2007, 12, 11, '2014-5-17', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Lots of Prayers', 'Thoroughbred', 'Kentucky', 'G', 2010, 4, 3, '2014-8-23', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Advancement', 'Thoroughbred', 'Kentucky', 'H', 2008, 5, 4, '2014-8-10', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Snooper Dauper', 'Thoroughbred', 'Washington', 'H', 2009, 4, 3, '2014-5-18', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Light My Heart', 'Thoroughbred', 'Washington', 'G', 2009, 5, 4, '2014-1-22', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Regal Valid', 'Thoroughbred', 'Washington', 'G', 2009, 6, 3, '2014-6-8', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Mr. Top Kat', 'Thoroughbred', 'Washington', 'R', 2009, 10, 9, '2014-6-29', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Financial Officer', 'Thoroughbred', 'Washington', 'G', 2010, 4, 3, '2014-6-21', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Northern Poptart', 'Thoroughbred', 'Idaho', 'G', 2007, 10, 8, '2014-8-2', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Marvin\'s Magic', 'Thoroughbred', 'Washington', 'G', 2008, 15, 12, '2014-9-5', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['War Wizard', 'Thoroughbred', 'Kentucky', 'G', 2009, 10, 8, '2014-9-1', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Chaching Pete', 'Thoroughbred', 'Washington', 'G', 2007, 13, 12, '2014-9-21', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Ugottabcatty', 'Thoroughbred', 'Washington', 'G', 2006, 10, 7, '2014-8-1', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Rainier Ice', 'Thoroughbred', 'Kentucky', 'G', 2008, 10, 8, '2014-6-20', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Brutally Handsome', 'Thoroughbred', 'Florida', 'G', 2007, 5, 3, '2014-9-1', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Daytona Beach', 'Thoroughbred', 'Washington', 'G', 2012, 2, 1, '2014-9-1', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Gavinator', 'Thoroughbred', 'Washington', 'C', 2012, 2, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Eight Ball Parker', 'Thoroughbred', 'Washington', 'G', 2012, 2, 1, '2014-7-18', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Ididn\'taskforthis', 'Thoroughbred', 'Washington', 'G', 2012, 1, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Carson\'s Start', 'Thoroughbred', 'Washington', 'G', 2012, 3, 1, '2014-7-13', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Moby', 'Thoroughbred', 'Washington', 'G', 2012, 3, 1, '2014-8-3', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Caddy Shack Cat', 'Thoroughbred', 'Washington', 'G', 2012, 1, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Prime Engine', 'Thoroughbred', 'Kentucky', 'C', 2012, 3, 1, '2014-9-13', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Val De Saire', 'Thoroughbred', 'Washington', 'F', 2012, 2, 1, '2014-9-6', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Old Fashioned Grit', 'Thoroughbred', 'Kentucky', 'G', 2012, 3, 1, '2014-8-24', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Bolshoi\'s Bluff', 'Thoroughbred', 'Washington', 'G', 2012, 2, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Trackattacker', 'Thoroughbred', 'Washington', 'G', 2012, 5, 4, '2014-9-7', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Private Boss', 'Thoroughbred', 'Washington', 'G', 2012, 4, 1, '2014-6-8', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Blueberry Smoothie', 'Thoroughbred', 'Washington', 'F', 2011, 3, 2, '2012-9-22', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Chu and You', 'Thoroughbred', 'Washington', 'F', 2011, 10, 6, '2014-9-7', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Hetty', 'Thoroughbred', 'Washington', 'F', 2010, 5, 3, '2014-7-26', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Finding More', 'Thoroughbred', 'Washington', 'F', 2010, 6, 4, '2013-6-20', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Timeless Pleasure', 'Thoroughbred', 'Kentucky', 'F', 2011, 2, 1, '2014-5-25', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['I Thought So', 'Thoroughbred', 'Kentucky', 'F', 2011, 3, 2, '2014-9-20', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Corla', 'Thoroughbred', 'Washington', 'F', 2010, 2, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Tactical Strike', 'Thoroughbred', 'Washington', 'C', 2011, 2, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Miners Thunder', 'Thoroughbred', 'Washington', 'G', 2011, 3, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Right Idea', 'Thoroughbred', 'Kentucky', 'G', 2011, 2, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Shadow Code', 'Thoroughbred', 'California', 'C', 2009, 2, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Dakota Firefly', 'Thoroughbred', 'Washington', 'G', 2009, 3, 0, '', 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2]]

new_meet = Meet.find_or_create_by!(name: 'Summer 2014', start_date: '2014-04-01 00:00:00', end_date: '2014-10-30 12:00:00', race_days: 60)
new_meet.save
meet = Meet.find_by_name('Summer 2014')
new_tel = Tel.find_or_create_by!(start_date: '2014-10-10', end_date: '2014-10-13', meet_id: meet.id, week_number: 1)
new_tel.save

categories.each do |category, conditions|
	new_category = Category.find_or_create_by!(name: category)
	case new_category.name
	when 'Age', 'Wins'
		new_category.datatype = 'Range'
	when 'Gender', 'Bred', 'Hasn\'t Won Since'
		new_category.datatype = 'Value'
	else
		new_category.datatype = 'Bool'
	end

	if new_category.save
		puts 'CREATED CATEGORY: ' << new_category.name
	end
	conditions.each do |condition|
		new_condition = Condition.find_or_create_by!(name: condition, category_id: new_category.id)
		if new_category.name == "Gender" || new_category.name == "Bred" || new_category.name == "Hasn\'t Won Since"
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
	if equip == 'Blinkers On'
		new_equip.required = true
	else
		new_equip.required = false
	end
	if new_equip.save
		puts 'CREATED EQUIPMENT/STATUS: ' << new_equip.name
	end
end

races.each do |race|
	new_race = Race.find_or_create_by!(name: race[0], description: race[1], status: race[2], category: race[3], distance_type: race[4], distance: race[5], purse: race[6])
	if new_race.save
		puts 'CREATED RACE: ' << new_race.name
	end
end

horses.each do |horse|
	owner = User.find_by_email(horse[8])
	trainer = User.find_by_email(horse[9])
	status = Status.find_by_name('Race Ready')

	if horse[7].empty?
		horse[7] = nil
	end

	new_horse = Horse.find_or_create_by!(name: horse[0], breed: horse[1], POB: horse[2], gender: horse[3], birth_year: horse[4], starts: horse[5], 
										wins: horse[6], last_win: horse[7], owner_id: owner.id, trainer_id: trainer.id, week_running: horse[10], status_id: status.id)
	if new_horse.save
		puts 'CREATED HORSE: ' << new_horse.name
	end
end

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













