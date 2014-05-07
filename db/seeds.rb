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
			'Other Equipment'=>['Cheek Piece', 'Cornell Collar', 'Front Wraps', 'Nasal Strip'], 'Age'=>['Ages 2-5', 'Age 1'], 
			'Wins'=> ['More Than 1 First', '0 Firsts'], 'Gender' => ['M', 'F', 'C', 'G', 'H', 'R']] 

statuses = ['Race Ready', 'Not Race Ready', 'Resting From Race', 'Vet\'s List', 'Steward\'s List']

#Races: [Race Number, Name, Description]
races = [[12, 'Big Race!', 'Claiming $7,500 (Age 1 F&M) @ 6F'], [8, 'Age Race', 'Claiming $9,500 (Ages 2-5 F&M) @ 6F'], 
		[9, 'No Wins', 'Claiming $4,500 (0 Wins F&M) @ 6F'], [20, 'Over 1 Win', 'Claiming $7,500 (F&M) @ 6F']]

#Horses: [Name, POB, Gender, DOB(year,month, day), Starts, Firsts, Seconds, Thirds, Earnings, Owner Email, Trainer Email]
horses = [['Owen\'s Horse', 'KY', 'C', '2012-04-01', 10, 5, 3, 4, 423445, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Test Horse', 'BC', 'R', '2008-11-01', 22, 4, 8, 3, 199999, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Date Test', 'CA', 'M', '2013-05-05', 11, 0, 0, 0, 1000, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com']]

categories.each do |category, conditions|
	new_category = Category.find_or_create_by!(name: category)
	
	case new_category.name
	when 'Age'
		new_category.datatype = 'Range'
	when 'Wins'
		new_category.datatype = 'Range'
	when 'Gender'
		new_category.datatype = 'Value'
	else
		new_category.datatype = 'Bool'
	end

	if new_category.save
		puts 'CREATED CATEGORY: ' << new_category.name
	end
	conditions.each do |condition|
		new_condition = Condition.find_or_create_by!(name: condition, category_id: new_category.id)
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

condition = Condition.find_by_name('Ages 2-5')
condition.lowerbound = 2
condition.upperbound = 5
condition.save
condition = Condition.find_by_name('Age 1')
condition.lowerbound = 1
condition.upperbound = 1
condition.save
condition = Condition.find_by_name('More Than 1 First')
condition.lowerbound = 2
condition.save
condition = Condition.find_by_name('0 Firsts')
condition.lowerbound = 0
condition.upperbound = 0
condition.save





