require 'app/buttons/_button.rb'
require 'app/colors/_color.rb'

require 'app/geometry/planar_geometry.rb'
require 'app/buttons/button_background.rb'
require 'app/buttons/button_text.rb'

# Represents a physical button.
# @note This class is not meant to be instantiated on its own.

class GenericButton < Button
	include PlanarGeometry
	include ButtonBackground
	include ButtonText
		
	def initialize(location: [0,0], size: [150, 50], text: "GENERIC BUTTON")
		super()

		set_dimensions(location, size)
		initialize_background
		initialize_text(text)

		self.border_color = Color.black
	end

	public
	attr_accessor :border_color

	def primitives
		[ rect.merge(border_color), text_hash, background_hash ].reverse
	end

end