class Horse < ActiveRecord::Base
	has_many :horsestatuses
	has_many :statuses, :through => :horsestatuses

	has_many :horse_conditions
	has_many :conditions, :through => :horse_conditions

	has_many :horseraces
	has_many :races, :through => :horseraces

	belongs_to :owner, class_name: 'User'
	belongs_to :trainer, class_name: 'User'

	def self.search(query)
  		where("lower(name) like ?", "%#{query}%".downcase)
	end
end
