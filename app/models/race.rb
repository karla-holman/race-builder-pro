class Race < ActiveRecord::Base
	has_many :horseraces
	has_many :horses, :through => :horseraces

	has_many :race_conditions
	has_many :conditions, :through => :race_conditions

	def self.search(query)
  		where("lower(name) like ?", "%#{query}%".downcase)
	end
end
