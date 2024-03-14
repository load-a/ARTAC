require 'app/windows/window_title.rb'
require 'app/windows/window_body.rb'

class Window
	include Geometry
	include WindowTitle
	include WindowBody

	@@all = []
	class << self
		
		def all
			@@all
		end

	end

	private

	def initialize( title, section_one = nil, section_two = nil )
		set_dimensions!([300, 200], [0, 0])
		initialize_title(title)
		initialize_sections(section_one, section_two)
	end

	public

	def move(new_location)
		dif_x = new_location[0] - x
		dif_y = new_location[1] - y

		set_location!(new_location)
		update_both_object_coordinates

		# buttons.each_value { |button| 
		# 	button.set_location! [button.x + dif_x, button.y + dif_y]
		# }
	end

	def primitives
		[
			rect.merge(Color::green),
			title_section,
			body_sections,
		].reverse
	end

	def background_hash
		background = rect
		background[:primitive_marker] = :solid
		background.merge(Color.white)
	end

end