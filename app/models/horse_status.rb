class HorseStatus < ActiveRecord::Base
	include PublicActivity::Common
	
	belongs_to :horse
	belongs_to :status
end
