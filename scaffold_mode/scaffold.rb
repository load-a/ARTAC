require 'app/geometry/dimensions.rb'
require 'app/scaffold_mode/number_buffer.rb'
# Depends on
# 	NumberBuffer module; Dimensions module
# Children -> SCAFFOLD constant

class Scaffold
	include Dimensions
	include NumberBuffer

	private
	attr_writer :number_buffer, :anchor_point, :cell_size

	def initialize
		set_dimensions!([0,0], [0,0])

		self.number_buffer = ""

		self.anchor_point = [0,0]
		@temp_anchor = [0,0]

		self.cell_size = 64

		@difference_x = 0
		@difference_y = 0
	end

	public 
	attr_reader :number_buffer, :anchor_point, :cell_size

	def set_anchor!(new_anchor)
		self.anchor_point = new_anchor
	end

	def change_location_to_match_anchor
		set_location! anchor_point
	end

	# Makes it so that the mouse sizes the scaffold from within.
	def extend_non_negative_dimensions
		self.width += cell_size if w >= 0
		self.height += cell_size if h >= 0
	end

	def reposition_anchor_if_dimensions_are_negative
		if width < 0
			self.width = width.abs
			self.anchor_point[0] = self.anchor_point[0] - width
			self.x = self.anchor_point[0]
		end

		if height < 0
			self.height = height.abs
			self.anchor_point[1] = self.anchor_point[1] - height
			self.y = self.anchor_point[1]
		end
	end

	def calculate_difference_with_reference(reference_point)
		@difference_x = reference_point[0] - anchor_point[0]
		@difference_y = reference_point[1] - anchor_point[1]
	end

	def adjust_location_with_difference(reference_point)
		self.x = reference_point[0] - @difference_x
		self.y = reference_point[1] - @difference_y
	end

	def change_anchor_to_match_location
		self.anchor_point = location
	end

	def calculate_size_from_reference(reference_point)
		self.width = (reference_point[0] - x) - ((reference_point[0] - x) % self.cell_size) 
		self.height = (reference_point[1] - y) - ((reference_point[1] - y) % self.cell_size) 
	end

	def reset_differences!
		@difference_x = 0
		@difference_y = 0
	end

	def info
		rect << {
			cell_size: cell_size,
			anchor: anchor_point
		}
	end

end
