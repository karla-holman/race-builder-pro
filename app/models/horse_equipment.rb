class HorseEquipment < ActiveRecord::Base
	belongs_to :horse
	belongs_to :equipment
end
