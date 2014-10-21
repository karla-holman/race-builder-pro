class Tel < ActiveRecord::Base
	has_many :days
	belongs_to :meet
end
