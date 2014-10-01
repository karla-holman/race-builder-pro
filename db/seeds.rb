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
races = [[1, 'Maiden Claiming Purse $9,975', '(Maiden, 3YO)','2014-10-03 12:00:00', 'Published', "Alternate",'Furlongs', 4.5, 5000, 150000,'2014-10-03 12:00:00'], 
		[2, 'Washington Maiden Claiming Purse $7,875', '(washington bred, F/M, 3+)', '2014-10-03', 'Published', "Alternate", 'Furlongs', 6, 2000, 8000, '2014-10-03 12:00:00'], 
		[3, 'Open Race Claiming $8,000', '', '2014-10-03 12:00:00', 'Published', "Protocol", 'Furlongs', 5.5, 6000, 2000, '2014-10-03 12:00:00'], 
		[4, 'NW2 Claiming $7,500', '(3+, NW2)', '2014-10-04 12:00:00', 'Draft', "Protocol", 'Miles', 1, 10000, 13000, '2014-10-03 12:00:00'], 
		[5, 'Hastings Handicap $50,000', '3+, F/M','2014-10-04 12:00:00', 'Draft', "Alternate", 'Miles', 1.25, 6000, 7600, '2014-10-03 12:00:00'],
		[6, 'WA State Legislators Stakes $35,000', '3YO, F/M, WA', '2014-10-04 12:00:00', 'Draft', "Stakes", 'Miles', 1.5, 2500, 1500, '2014-10-03 12:00:00'],
		[7, 'NWSS Cahill Road Stakes $75,000', '2YO WA', '2014-10-05 12:00:00', 'Published', "Stakes", 'Miles', 1.25, 3600, 5000, '2014-10-03 12:00:00'],
		[8, 'Maiden Claiming Purse $19,975', '(Maiden, 2YO)','2014-10-05 12:00:00', 'Published', "Alternate",'Furlongs', 4.5, 7000, 9000,'2014-10-03 12:00:00'], 
		[9, 'Washington Maiden Claiming Purse $17,875', '(washington bred)', '2014-10-05 12:00:00', 'Published', "Alternate", 'Furlongs', 6, 5000, 7000, '2014-10-03 12:00:00'], 
		[10, 'Open Race Claiming $18,000', '', '2014-09-27 12:00:00', 'Published', "Protocol", 'Furlongs', 5.5, 8999, 11000, '2014-09-30 12:00:00'], 
		[11, 'NW2 Claiming $17,500', '(NW2)', '2014-09-28 12:00:00', 'Draft', "Protocol", 'Miles', 1, 3100, 6000, '2014-09-30 12:00:00'], 
		[12, 'Cahill Road $500,000', '3+','2014-09-29 12:00:00', 'Draft', "Alternate", 'Miles', 1.25, 14000, 10000, '2014-09-30 12:00:00'],
		[13, 'WA State Legislators Stakes $325,000', '3YO, F/M, WA', '2014-09-27 12:00:00', 'Draft', "Stakes", 'Miles', 1.5, 4200, 8000, '2014-09-30 12:00:00'],
		[14, 'Hastings Stakes $715,000', '2YO WA', '2014-09-29 12:00:00', 'Published', "Stakes", 'Miles', 1.25, 1800, 16000, '2014-09-30 12:00:00']]

#Horses: [Name, POB, Gender, DOB(year,month, day), Starts, Firsts, Owner Email, Trainer Email, Week Running]
horses = [['Owen Hope', 'KY', 'G', '2011-04-01', 5, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Greg Hope', 'CA', 'C', '2011-11-01', 0, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Jacob Pollowitz', 'WA', 'F', '2010-05-05', 1, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Sharon Hope', 'WA', 'F', '2010-05-05', 2, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Alison Pollowitz', 'WA', 'M', '2009-05-05', 3, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Michael Pollowitz', 'KY', 'F', '2010-05-05', 7, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2],
		['Sire and Son', 'W', 'C', '2011-05-05', 25, 7, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 3],
		['Hope Media', 'KY', 'G', '2010-05-05', 7, 1, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com', 2]]

new_meet = Meet.find_or_create_by!(name: 'Summer 2014', start_date: '2014-04-01 00:00:00', end_date: '2014-10-30 12:00:00', race_days: 60)
new_meet.save
meet = Meet.find_by_name('Summer 2014')
new_tel = Tel.find_or_create_by!(weekend_start: '2014-09-05 00:00:00', meet_id: meet.id, week_number: 1)
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
	new_race = Race.find_or_create_by!(race_number: race[0], name: race[1], description: race[2], status: race[4], race_type: race[5], distance_type: race[6], distance: race[7], claiming_level: race[8], claiming_purse: race[9], close_date: race[10])
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
										firsts: horse[5], owner_id: owner.id, trainer_id: trainer.id, week_running: horse[8])
	horse_status = HorseStatus.new(:horse_id => new_horse.id, :status_id => 2)
	if new_horse.save
		puts 'CREATED HORSE: ' << new_horse.name
	end
	if horse_status.save
		puts 'CREATED HORSE STATUS: '<< Status.find(horse_status.status_id).name
	end
end

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





