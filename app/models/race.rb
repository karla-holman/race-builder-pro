class Race < ActiveRecord::Base
	include PublicActivity::Common
	
	has_many :horseraces
	has_many :horses, :through => :horseraces

	has_many :race_winners

	has_many :race_conditions
	has_many :conditions, :through => :race_conditions

	belongs_to :tel

	def self.search(query)
  		where("lower(name) like ?", "%#{query}%".downcase)
	end
end
