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
categories = Hash['Medication'=>['Bute', 'First Time Lasix', 'Lasix On', 'Lasix Off'] , 'Equipment'=>['Blinkers On', 'Blinkers Off', 'No Blinkers'], 
			'Other Equipment'=>['Cheek Piece', 'Cornell Collar', 'Front Wraps', 'Nasal Strip'], 'Age'=>['3+ Years Old', '3 Years Old'], 
			'Wins'=> ['Maiden', 'NW2'], 'Gender' => ['M', 'F', 'C', 'G', 'H', 'R'], 'Bred' => ['WA'], 'Hasn\'t Won Since' => ['2012']] 

statuses = ['Race Ready', 'Not Race Ready', 'Resting From Race', 'Vet\'s List', 'Steward\'s List']

#Races: [Race Number, Name, Description, Datetime]
races = [[1, 'Maiden Claiming Purse $9,975', 'INCLUDES $2,494 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION (3 years old)','2014-05-22 10:30:00'], 
		[2, 'Washington Maiden Claiming Purse $7,875', 'INCLUDES $2,363 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION (washington bred, fillies and mares, 3 years and older)', '2014-05-29 9:30:00'], 
		[3, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'], 
		[4, 'NW2 Claiming $7,500', 'INCLUDES $1,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION (3 years and older)', '2014-06-10 14:00:00'], [3, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[5, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[6, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[7, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[8, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[9, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[10, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[11, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[12, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[13, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[14, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[15, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[16, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[17, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[18, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[19, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[20, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[21, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[22, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[23, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[24, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[25, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[26, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[27, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[28, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[29, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[30, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[31, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[32, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[33, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[34, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[35, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[36, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[37, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[38, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[39, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[40, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[41, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[42, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[43, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[44, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[45, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[46, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[47, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[48, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[49, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[50, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[51, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[52, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[53, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[54, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[55, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[56, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[57, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[58, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[59, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[60, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[61, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[62, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[63, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[64, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[65, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[66, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[67, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[68, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[69, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[70, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[71, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[72, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[73, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[74, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[75, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[76, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[77, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[78, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[79, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[80, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[81, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[82, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[83, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[84, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[85, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[86, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[87, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[88, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[89, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[90, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[91, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00'],
		[92, 'Open Race Claiming $8,000', 'INCLUDES $2,000 FROM THE MUCKLESHOOT INDIAN TRIBE ECONOMIC DEVELOPMENT CONTRIBUTION', '2014-06-01 12:00:00']]

#Horses: [Name, POB, Gender, DOB(year,month, day), Starts, Firsts, Seconds, Thirds, Earnings, Owner Email, Trainer Email]
horses = [['Owen Hope', 'KY', 'G', '2011-04-01', 5, 0, 2, 2, 10000, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Greg Hope', 'CA', 'C', '2011-11-01', 0, 0, 0, 0, 0, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Jacob Pollowitz', 'WA', 'F', '2010-05-05', 1, 0, 0, 1, 2000, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Sharon Hope', 'WA', 'F', '2010-05-05', 2, 0, 1, 1, 1000, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Alison Pollowitz', 'WA', 'M', '2009-05-05', 3, 0, 2, 1, 5000, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Michael Pollowitz', 'KY', 'F', '2010-05-05', 7, 0, 3, 0, 8000, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Sire and Son', 'W', 'C', '2011-05-05', 25, 7, 3, 2, 30000, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Hope Media', 'KY', 'G', '2010-05-05', 7, 1, 2, 3, 8000, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com']]

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
	new_race = Race.find_or_create_by!(race_number: race[0], name: race[1], description: race[2])
	date = DateTime.parse(race[3]).to_s
	new_race.race_datetime = date
	if new_race.save
		puts 'CREATED RACE: ' << new_race.name
	end
end

horses.each do |horse|
	dob = DateTime.parse(horse[3]).to_date.to_s
	owner = User.find_by_email(horse[9])
	trainer = User.find_by_email(horse[10])
	new_horse = Horse.find_or_create_by!(name: horse[0], POB: horse[1], gender: horse[2], DOB: dob, starts: horse[4], 
										firsts: horse[5], seconds: horse[6], thirds: horse[7], earnings: horse[8], owner_id: owner.id, trainer_id: trainer.id)
	horse_status = HorseStatus.new(:horse_id => new_horse.id, :status_id => 2)
	if new_horse.save
		puts 'CREATED HORSE: ' << new_horse.name
	end
	if horse_status.save
		puts 'CREATED HORSE STATUS: '<< Status.find(horse_status.status_id).name
	end
end

condition = Condition.find_by_name('3+ Years Old')
condition.lowerbound = 3
condition.save
condition = Condition.find_by_name('3 Years Old')
condition.lowerbound = 3
condition.upperbound = 3
condition.save
condition = Condition.find_by_name('Maiden')
condition.lowerbound = 0
condition.upperbound = 0
condition.save
condition = Condition.find_by_name('NW2')
condition.lowerbound = 0
condition.upperbound = 1
condition.save





