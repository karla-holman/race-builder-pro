class Race < ActiveRecord::Base
	has_many :horseraces
	has_many :horses, :through => :horseraces

	has_many :raceconditions
	has_many :conditions, :through => :raceconditions
end
