class Equipment < ActiveRecord::Base
	has_many :horse_equipments
	has_many :horses, :through => :horse_equipments
end
