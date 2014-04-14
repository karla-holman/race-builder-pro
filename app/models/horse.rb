class Horse < ActiveRecord::Base
	belongs_to :owner, class_name: 'User'
	belongs_to :trainer, class_name: 'User'
end
