require 'app/geometry/location.rb'
require 'app/geometry/size.rb'

# Combines Location (x and y coordinates) and Size (width and height).
module Dimensions
	include Location
	include Size

	def rect
		dimensions.merge {:primitive_marker => :border}
	end

	# A hash containing the four dimensions of an object.
	# @note The keys are named to fit DragonRuby's attribute conventions. 
	# @return [Hash]
	def dimensions
		{
			x: x,
			y: y,
			w: width,
			h: height,
		}
	end

	# @note Only meant to be used with object initialization.
	# @return [Void]
	def set_dimensions(location, size)
		set_location location
		set_size size
	end
	alias change_dimensions set_dimensions

end
