class HorseMeet < ActiveRecord::Base
	belongs_to :horse
	belongs_to :meet
end
