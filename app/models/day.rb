class Day < ActiveRecord::Base
	has_many :races
	belongs_to :tel
end
