require 'app/geometry/dimensions.rb'

module Perimeter
	include Dimensions

	public
	# The point opposite the object's base.
	# @return [Array<Integer>]
	def apex
		[apex_x, apex_y]
	end
	alias summit apex

	def apex_x
		x+width
	end

	def apex_y
		y+height
	end

	# @return [Integer]
	def bottom_side
		y
	end
	alias bottom bottom_side

	# @return [Integer]
	def top_side
		apex[1]
	end
	alias top top_side

	# @return [Integer]
	def left_side
		x
	end
	alias left left_side

	# @return [Integer]
	def right_side
		apex[0]
	end
	alias right right_side

	def horizontal_center
		x + width/2
	end

	def vertical_center
		y + height/2
	end
	
end