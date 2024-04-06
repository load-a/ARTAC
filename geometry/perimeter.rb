require 'app/geometry/dimensions.rb'

module Perimeter
	include Dimensions

	public

	alias base location

	alias bottom_side y
	alias bottom y

	alias left_side x
	alias left x

	# The point opposite the object's base.
	# @return [Array<Integer>]
	def apex
		[apex_x, apex_y]
	end
	alias summit apex

	# The rightmost X coordinate.
	# @return Integer
	def apex_x
		x+width
	end
	alias right_side apex_x
	alias right apex_x

	# The topmost Y coordinate.
	# @return Integer
	def apex_y
		y+height
	end
	alias top_side apex_y
	alias top apex_y

	# The object's center coordinates.
	# @note This is the center of the object's hitbox (see #Dimensions::rect) and not the center of the object's visual
	# 	appearance or true geometric center (unless it's a rectangle).
	# @return [Array<Integer>]
	def center_point
		[horizontal_center, vertical_center]
	end

	# The X coordinate of the object's center.
	# @return Integer
	def horizontal_center
		x + width/2
	end

	# The Y coordinate of the object's center.
	# @return Integer
	def vertical_center
		y + height/2
	end
	
end