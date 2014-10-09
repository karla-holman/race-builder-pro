class Horserace < ActiveRecord::Base
	include PublicActivity::Common
	
	belongs_to :horse
	belongs_to :race
end
