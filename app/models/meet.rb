class Meet < ActiveRecord::Base
	has_many :tels

	has_many :horse_meets
	has_many :horses, :through => :horse_meets
end
