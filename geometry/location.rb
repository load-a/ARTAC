# The object's position in space (x and y). 
# @note A "point" refers to the attributes X and Y together in an array. This term is used throughout the program.

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
	alias position location
	alias base location

	# @note Only meant to be used with object initialization.
	# @return [Void]
	def set_location!(location)
		self.x, self.y = location
	end

end
