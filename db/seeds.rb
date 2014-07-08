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

#Races: [Race Number, Name, Description, Datetime]
races = [[1, 'Maiden Claiming Purse $9,975', '(Maiden, 3YO)','2014-07-11 10:30:00', 'Published', "Alternate",'Furlongs', 4.5], 
		[2, 'Washington Maiden Claiming Purse $7,875', '(washington bred, F/M, 3+)', '2014-07-12 9:30:00', 'Published', "Alternate", 'Furlongs', 6], 
		[3, 'Open Race Claiming $8,000', '', '2014-07-11 12:00:00', 'Published', "Protocol", 'Furlongs', 5.5], 
		[4, 'NW2 Claiming $7,500', '(3+, NW2)', '2014-07-13 14:00:00', 'Draft', "Protocol", 'Miles', 1], 
		[5, 'Hastings Handicap $50,000', '3+, F/M','2014-07-11 10:30:00', 'Draft', "Alternate", 'Miles', 1.25],
		[6, 'WA State Legislators Stakes $35,000', '3YO, F/M, WA', '2014-07-12 10:30:00', 'Draft', "Stakes", 'Miles', 1.5],
		[7, 'NWSS Cahill Road Stakes $75,000', '2YO WA', '2014-07-13 12:00:00', 'Published', "Stakes", 'Miles', 1.25]]

#Horses: [Name, POB, Gender, DOB(year,month, day), Starts, Firsts, Owner Email, Trainer Email]
horses = [['Owen Hope', 'KY', 'G', '2011-04-01', 5, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Greg Hope', 'CA', 'C', '2011-11-01', 0, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Jacob Pollowitz', 'WA', 'F', '2010-05-05', 1, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Sharon Hope', 'WA', 'F', '2010-05-05', 2, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Alison Pollowitz', 'WA', 'M', '2009-05-05', 3, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Michael Pollowitz', 'KY', 'F', '2010-05-05', 7, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Sire and Son', 'W', 'C', '2011-05-05', 25, 7, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Hope Media', 'KY', 'G', '2010-05-05', 7, 1, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com']]

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
	new_race = Race.find_or_create_by!(race_number: race[0], name: race[1], description: race[2], status: race[4], race_type: race[5], distance_type: race[6], distance: race[7])
	date = DateTime.parse(race[3]).to_s
	new_race.race_datetime = date
	if new_race.save
		puts 'CREATED RACE: ' << new_race.name
	end
end

horses.each do |horse|
	dob = DateTime.parse(horse[3]).to_date.to_s
	owner = User.find_by_email(horse[6])
	trainer = User.find_by_email(horse[7])
	new_horse = Horse.find_or_create_by!(name: horse[0], POB: horse[1], gender: horse[2], DOB: dob, starts: horse[4], 
										firsts: horse[5], owner_id: owner.id, trainer_id: trainer.id)
	horse_status = HorseStatus.new(:horse_id => new_horse.id, :status_id => 2)
	if new_horse.save
		puts 'CREATED HORSE: ' << new_horse.name
	end
	if horse_status.save
		puts 'CREATED HORSE STATUS: '<< Status.find(horse_status.status_id).name
	end
end

race1 = Race.find_by_name('Open Race Claiming $8,000')
race2 = Race.find_by_name('NWSS Cahill Road Stakes $75,000')
@tel = Tel.new(:race_id => race1.id, :section => 'Protocol', :day => 'Friday')
@tel.save
@tel = Tel.new(:race_id => race2.id, :section => 'Stakes', :day => 'Sunday')
@tel.save

condition = Condition.find_by_name('3+')
condition.lowerbound = 3
condition.save
condition = Condition.find_by_name('3YO')
condition.lowerbound = 3
condition.upperbound = 3
condition.save
condition = Condition.find_by_name('2YO')
condition.lowerbound = 2
condition.upperbound = 2
condition.save
condition = Condition.find_by_name('Maiden')
condition.lowerbound = 0
condition.upperbound = 0
condition.save
condition = Condition.find_by_name('NW2')
condition.lowerbound = 0
condition.upperbound = 1
condition.save





