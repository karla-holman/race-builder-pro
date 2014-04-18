class Status < ActiveRecord::Base
	has_many :horseraces
	has_many :horses, :through => :horseraces
end
