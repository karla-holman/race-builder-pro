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

#Category Hash Array: Category => Conditions
categories = Hash['Medication'=>['Bute', 'First Time Lasix', 'Lasix On', 'Lasix Off'] , 'Equipment'=>['Blinkers On', 'Blinkers Off', 'No Blinkers'], 
			'Other Equipment'=>['Cheek Piece', 'Cornell Collar', 'Front Wraps', 'Nasal Strip']]

statuses = ['Race Ready', 'Not Race Ready', 'Resting From Race', 'Vet\'s List', 'Steward\'s List']

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
