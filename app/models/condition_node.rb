class ConditionNode < ActiveRecord::Base
	belongs_to :parent, class_name: 'ConditionNode', foreign_key: :parent_id
    has_many :children, class_name: 'ConditionNode', foreign_key: :parent_id


	#Types
	ROOT  = 0
	OPERATOR = 1
	CONDITION = 2

	#Operators
	OR = 0
	AND = 1

	def setAsRoot
  		self.node_type = ROOT
	end

	def isRoot
  		if self.node_type == ROOT
  			return true
  		else
  			return false
  		end
	end

	def setOperatorOr
  		self.value = OR
	end

	def setTypeCondition
  		self.node_type = CONDITION
	end

	def setTypeOperator
  		self.node_type = OPERATOR
	end

	def isOperator
  		if self.node_type == OPERATOR
  			return true
  		else
  			return false
  		end
	end

	def isCondition
  		if self.node_type == CONDITION
  			return true
  		else
  			return false
  		end
	end

	def getOperator
  		if self.value == 0
  			return "OR"
  		else
  			return "AND"
  		end
	end

	def getCondition
		condition = Condition.find_by_id(self.value)
		if condition
  			return condition.name
  		else
  			return ""
  		end
	end

	def race_name
		race = Race.find_by_id(self.value)
		if race
			return race.name
		else
			return "no race connected"
		end
	end

	def getRace
		race = Race.find_by_id(self.value)
		if race
			return race
		else
			return nil
		end
	end

	def getExpressionString	
		if self.children.any?
			if self.children.length > 1
				expression_string = "( "

				self.children.each do |child|
					expression = child.getExpressionString
					if !expression.blank?
						if child != self.children.first
							expression_string += " " + self.getOperator
						end

						expression_string += " " + expression

						if child != self.children.last
							
						end
					end
				end
				expression_string += " )"
			else
				child = self.children.first
				expression_string = child.getExpressionString
			end
		else
			if self.isRoot
				expression_string =  "No Conditions"
			elsif self.isCondition
				expression_string = self.getCondition
			else
				expression_string = ""
			end
		end
		return expression_string
	end




















end
