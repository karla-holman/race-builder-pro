class Tel < ActiveRecord::Base
	has_many :races
	belongs_to :week
end
