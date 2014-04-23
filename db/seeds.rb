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
			'Other Equipment'=>['Cheek Piece', 'Cornell Collar', 'Front Wraps', 'Nasal Strip']]

statuses = ['Race Ready', 'Not Race Ready', 'Resting From Race', 'Vet\'s List', 'Steward\'s List']

#Races: [Race Number, Name, Description]
races = [[12, 'Big Race!', 'Claiming $7,500 (3&UP F&M) @ 6F']]

#Horses: [Name, POB, Gender, DOB(year,month, day), Starts, Firsts, Seconds, Thirds, Earnings, Owner Email, Trainer Email]
horses = [['Owen\'s Horse', 'KY', 'C', '2012-04-01', 10, 5, 3, 4, 423445, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Test Horse', 'BC', 'R', '2008-11-01', 22, 4, 8, 3, 199999, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com'],
		['Date Test', 'CA', 'M', '2013-05-05', 11, 0, 0, 0, 1000, 'owner@hopemediahouse.com', 'trainer@hopemediahouse.com']]

categories.each do |category, conditions|
	new_category = Category.find_or_create_by!(name: category)
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
	if new_horse.save
		puts 'CREATED HORSE: ' << new_horse.name
	end
end
