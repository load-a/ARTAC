require 'app/geometry/location.rb'

# The module responsible for the geometric translation of an object.
module Movement

	# Moves an object relative to its current position.
	# @param distances [Array<Integer>] The distances to move in the X and Y direction.
	# @return [Void]
	def move_relative_to_position(distances)
		self.x += distances[0]
		self.y += distances[1]
	end
	alias move move_relative_to_position


	# Moves object to an absolute position on the screen.
	# @param location [Array<Integer>] The x and y coordinates of the place the object is being moved to.
	# @return [Void]
	def move_to_absolute_position(location)
		self.x, self.y = location
	end
	alias set_position! move_to_absolute_position
	alias change_position! move_to_absolute_position

end
