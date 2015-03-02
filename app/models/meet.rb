class Meet < ActiveRecord::Base
	has_many :weeks

	has_many :horse_meets, :dependent => :destroy
	has_many :horses, :through => :horse_meets
end
