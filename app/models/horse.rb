class Horse < ActiveRecord::Base
	include PublicActivity::Common

	belongs_to :status

	has_many :horseraces
	has_many :races, :through => :horseraces

	has_many :horse_equipments
	has_many :equipment, :through => :horse_equipments

	has_many :horse_meets
	has_many :meets, :through => :horse_meets

	has_many :race_winners

	belongs_to :owner, class_name: 'User'
	belongs_to :trainer, class_name: 'User'

	def self.search(query)
  		where("lower(name) like ?", "%#{query}%".downcase)
	end
end
