# Imparts X and Y coordinates to an object and provides methods for manipulating them.
# @note Throughout the program, "point" will be used synonymously with #location.

module Location

	private
	attr_writer :x, :y

	public 
	attr_reader :x, :y

	# The object's Cartesian coordinates.
	# @return [Array<Integer>]
	def location
		[x, y]
	end
	alias base location

	# @return [Void]
	def set_location!(new_location)
		self.x, self.y = new_location
	end

	def set_x!(new_x)
		self.x = new_x
	end

	def set_y!(new_y)
		self.y = new_y
	end

	def move_location!(location_difference)
		self.x += location_difference[0]
		self.y += location_difference[1]
	end
	alias move! move_location!

end
