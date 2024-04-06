# Imparts X and Y coordinates to an object and provides methods for manipulating them.
# @note Throughout the program, "point" will be used synonymously with #location.

module Location

	private
	attr_writer :x, :y

	public 
	attr_reader :x, :y

	def set_x(new_x)
		self.x = new_x
	end
	alias change_x set_x

	def set_y(new_y)
		self.y = new_y
	end
	alias change_y set_y

	# @return [Void]
	def set_location(new_location)
		self.x, self.y = new_location
	end
	alias change_location set_location


	def adjust_x(x_offset)
		self.x += x_offset
	end
	alias move_x adjust_x

	def adjust_y(y_offset)
		self.y += y_offset
	end
	alias move_y adjust_y

	def adjust_location(location_offset)
		self.x += location_offset[0]
		self.y += location_offset[1]
	end
	alias move adjust_location


	# The object's Cartesian coordinates.
	# @return [Array<Integer>]
	def location
		[x, y]
	end
	alias point location

end
