require 'app/windows/window_title.rb'
require 'app/windows/window_body.rb'
require 'app/windows/window_buttons.rb'

class Window
	include Geometry
	include WindowTitle
	include WindowBody

	@@all = []
	@@id_counter = 0
	class << self
		
		def all
			@@all
		end

	end

	private
	attr_writer :id
	attr_accessor :section_list

	def initialize(location, title, content_list)

		location[1] -= BOTTOM_PADDING # This will be added back in the render
		set_dimensions!(location, [0, 0])

		self.section_list = Array.new

		initialize_title_section(title)
		initialize_content_sections(content_list)

		self.id = "WIN" + @@id_counter.to_s
		@@id_counter += 1
	end

	def available_height
		remaining_height = self.height 

		section_list.each { |item| 
			remaining_height -= item[:h]
		}

		remaining_height - BOTTOM_PADDING
	end

	def available_width
		self.width - SIDE_PADDING*2
	end

	public
	attr_reader :id

	def move(new_location)
		offset_point = Geometry::coordinate_difference(new_location, self.location)

		set_location!(new_location)
		move_contents offset_point
	end

	def move_relative(offset)
		new_location = Geometry::coordinate_sum(self.location, offset)
		move(new_location)
	end

	def primitives
		[
			rect,
			ClickButton.new(location: [ exit_button_rect[:x] ,exit_button_rect[:y] ], text: "x", size: [25, 25]).primitives,
			title_section,
			content_section,
			background_hash,
		].reverse
	end

	def exit_button_rect
		{
			x: self.x+5,
			y: self.apex[1]-30,
			w: 25,
			h: 25,
		}
	end

	def rect
		{
			x: x,
			y: y-BOTTOM_PADDING,
			w: width,
			h: height+BOTTOM_PADDING,
			primitive_marker: :border
		}
	end

	def background_hash
		background = rect
		background[:primitive_marker] = :solid
		background.merge(Color.white)
	end

end