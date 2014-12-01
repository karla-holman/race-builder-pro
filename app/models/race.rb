class Race < ActiveRecord::Base
	include PublicActivity::Common
	
	has_many :horseraces
	has_many :horses, :through => :horseraces

	has_many :race_winners

	has_many :race_conditions
	has_many :conditions, :through => :race_conditions

	belongs_to :tel

	has_one :race_date

	has_many :claiming_prices

	def self.search(query)
  		where("lower(name) like ?", "%#{query}%".downcase)
	end
end
