require 'app/windows/window_title.rb'
require 'app/windows/window_body.rb'
require 'app/windows/window_buttons.rb'

class Window
	include Geometry
	include WindowTitle
	include WindowBody
	include WindowButtons

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

	def initialize( location, title, content_list, number_of_buttons = 0 )
		set_dimensions!(location, [0, 0])
		self.section_list = Array.new

		initialize_title_section(title)
		initialize_content_sections(content_list)
		# initialize_buttons(number_of_buttons)

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
		dif_x = new_location[0] - x
		dif_y = new_location[1] - y

		set_location!(new_location)
		update_both_section_coordinates

		buttons.each_value { |button| 
			button.set_location! [button.x + dif_x, button.y + dif_y]
		}
	end

	def primitives
		[
			rect,
			# button_primitives,
			title_section,
			content_section,
			background_hash,
			section_list.map {|d| 
				d[:primitive_marker] = :border
				d.merge(Color.green)
			}
		].reverse
	end

	def background_hash
		background = rect
		background[:primitive_marker] = :solid
		background.merge(Color.white)
	end

end