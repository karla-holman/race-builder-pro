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
categories = Hash['Medication'=>['Bute', 'First Time Lasix', 'Lasix On', 'Lasix Off'] , 'Equipment'=>['Blinkers On'], 
			'Other Equipment'=>['Cheek Piece', 'Cornell Collar', 'Front Wraps', 'Nasal Strip'], 'Age'=>['3+', '3YO', '2YO'], 
			'Wins'=> ['Maiden', 'NW2'], 'Gender' => ['M', 'F', 'C', 'G', 'H', 'R'], 'Bred' => ['WA'], 'Hasn\'t Won Since' => ['2012']] 

statuses = ['Race Ready', 'Not Race Ready', 'Resting From Race', 'Vet\'s List', 'Steward\'s List', 'Inactive']

#Races: [Name, Description, Status, Category, Distance Type, Distance]
races = [['Maiden Claiming Purse $9,975', '(Maiden, 3YO)', 'Published', "Alternate",'Furlongs', 4.5], 
		['Washington Maiden Claiming Purse $7,875', '(washington bred, F/M, 3+)', 'Published', "Alternate", 'Furlongs', 6], 
		['Open Race Claiming $8,000', '', 'Published', "Protocol", 'Furlongs', 5.5], 
		['NW2 Claiming $7,500', '(3+, NW2)', 'Draft', "Protocol", 'Miles', 1], 
		['Hastings Handicap $50,000', '3+, F/M', 'Draft', "Alternate", 'Miles', 1.25],
		['WA State Legislators Stakes $35,000', '3YO, F/M, WA', 'Draft', "Stakes", 'Miles', 1.5],
		['NWSS Cahill Road Stakes $75,000', '2YO WA', 'Published', "Stakes", 'Miles', 1.25],
		['Maiden Claiming Purse $19,975', '(Maiden, 2YO)', 'Published', "Alternate",'Furlongs', 4.5], 
		['Washington Maiden Claiming Purse $17,875', '(washington bred)', 'Published', "Alternate", 'Furlongs', 6], 
		['Open Race Claiming $18,000', '', 'Published', "Protocol", 'Furlongs', 5.5], 
		['NW2 Claiming $17,500', '(NW2)', 'Draft', "Protocol", 'Miles', 1], 
		['Cahill Road $500,000', '3+', 'Draft', "Alternate", 'Miles', 1.25],
		['WA State Legislators Stakes $325,000', '3YO, F/M, WA', 'Draft', "Stakes", 'Miles', 1.5],
		['Hastings Stakes $715,000', '2YO WA', 'Published', "Stakes", 'Miles', 1.25]]

#Horses: [Name, POB, Gender, Birth Year, Starts, Wins, Owner Email, Trainer Email, Week Running]
horses = [['Owen Hope', 'KY', 'G', 2011, 5, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Greg Hope', 'CA', 'C', 2011, 0, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Jacob Pollowitz', 'WA', 'F', 2010, 1, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Sharon Hope', 'WA', 'F', 2010, 2, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Alison Pollowitz', 'WA', 'M', 2009, 3, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Michael Pollowitz', 'KY', 'F', 2010, 7, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Sire and Son', 'W', 'C', 2011, 25, 7, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Hope Media', 'KY', 'G', 2010, 7, 1, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2]]

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

races.each do |race|
	new_race = Race.find_or_create_by!(name: race[0], description: race[1], status: race[2], category: race[3], distance_type: race[4], distance: race[5])
	if new_race.save
		puts 'CREATED RACE: ' << new_race.name
	end
end

horses.each do |horse|
	owner = User.find_by_email(horse[6])
	trainer = User.find_by_email(horse[7])
	new_horse = Horse.find_or_create_by!(name: horse[0], POB: horse[1], gender: horse[2], birth_year: horse[3], starts: horse[4], 
										wins: horse[5], owner_id: owner.id, trainer_id: trainer.id, week_running: horse[8])
	horse_status = HorseStatus.new(:horse_id => new_horse.id, :status_id => 2)
	if new_horse.save
		puts 'CREATED HORSE: ' << new_horse.name
	end
	if horse_status.save
		puts 'CREATED HORSE STATUS: '<< Status.find(horse_status.status_id).name
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
female = Condition.find_by_name('F')
male = Condition.find_by_name('M')
washington = Condition.find_by_name('WA')




race = Race.find_by_name('Maiden Claiming Purse $9,975')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: three.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: maiden.id)
race_condition.save

race = Race.find_by_name('Washington Maiden Claiming Purse $7,875')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: threeplus.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: female.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: male.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: washington.id)
race_condition.save

race = Race.find_by_name('NW2 Claiming $7,500')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: threeplus.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: nwtwo.id)
race_condition.save

race = Race.find_by_name('Hastings Handicap $50,000')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: threeplus.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: female.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: male.id)
race_condition.save

race = Race.find_by_name('WA State Legislators Stakes $35,000')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: three.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: female.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: male.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: washington.id)
race_condition.save

race = Race.find_by_name('NWSS Cahill Road Stakes $75,000')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: two.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: washington.id)
race_condition.save

race = Race.find_by_name('Maiden Claiming Purse $19,975')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: maiden.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: two.id)
race_condition.save

race = Race.find_by_name('Washington Maiden Claiming Purse $17,875')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: washington.id)
race_condition.save

race = Race.find_by_name('NW2 Claiming $17,500')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: nwtwo.id)
race_condition.save

race = Race.find_by_name('Cahill Road $500,000')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: threeplus.id)
race_condition.save

race = Race.find_by_name('WA State Legislators Stakes $325,000')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: three.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: female.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: male.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: washington.id)
race_condition.save

race = Race.find_by_name('Hastings Stakes $715,000')
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: washington.id)
race_condition.save
race_condition = RaceCondition.find_or_create_by!(race_id: race.id, condition_id: two.id)
race_condition.save













