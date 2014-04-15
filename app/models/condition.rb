class Condition < ActiveRecord::Base
	belongs_to :category, class_name: 'ConditionCategory'
end
