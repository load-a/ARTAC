require 'app/geometry/dimensions.rb'

# A module for handling all geometric attributes the object may have.
module Geometry
	include Dimensions

	# The point opposite the object's base.
	# @return [Array<Integer>]
	def apex
		[x+width, y+height]
	end
	alias summit apex

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

	# Determines whether two objects collide.
	# @note False will be returned for objects that only touch!
	# @param primary_object [Object]
	# @param	secondary_object [Object]
	# @return [Boolean]
	def self.collision_check?(primary_object, secondary_object)
		primary_object.top > secondary_object.bottom and
		primary_object.left < secondary_object.right and
		primary_object.bottom < secondary_object.top and
		primary_object.right > secondary_object.left
	end

end
