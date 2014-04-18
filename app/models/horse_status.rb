class HorseStatus < ActiveRecord::Base
	belongs_to :horse
	belongs_to :status
end
