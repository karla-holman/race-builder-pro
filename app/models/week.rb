class Week < ActiveRecord::Base
	belongs_to :meet
	has_many :tels, :dependent => :destroy 
end
