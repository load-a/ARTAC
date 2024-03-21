require 'app/buttons/click_button.rb'
require 'app/windows/window_constants.rb'

module WindowButtons
	include WindowConstants

	private
	attr_writer :buttons
	def button_locations
		{
			:exit_location => [ x+5, apex[1]-30 ],
			:right_location => [ x+SIDE_PADDING, y+BOTTOM_PADDING ],
			:left_location => [ apex_x - SIDE_PADDING - DEFAULT_BUTTON_WIDTH, y+BOTTOM_PADDING ],
			:center_location => [ horizontal_center-DEFAULT_BUTTON_WIDTH/2, y+BOTTOM_PADDING ],
		}
	end


	public
	attr_reader :buttons
	def initialize_buttons(number_of_buttons)

		self.buttons = Hash.new(0)

		assign_buttons(number_of_buttons)

	end

	def double_buttons(first_label = 'Confirm', second_label = 'Cancel')
		return if buttons.length >= 2
		self.buttons[first_label] = ClickButton.new(location: button_locations[:right_location], text: first_label, size: [DEFAULT_BUTTON_WIDTH, DEFAULT_BUTTON_HEIGHT])
		self.buttons[second_label] = ClickButton.new(location: button_locations[:left_location], text: second_label, size: [DEFAULT_BUTTON_WIDTH, DEFAULT_BUTTON_HEIGHT])
	end

	def add_exit
		self.buttons[:exit] = ClickButton.new(location: button_locations[:exit_location], text: "x", size: EXIT_SIZE)
	end

	def single_button(label = 'Okay')
		self.buttons[label] = ClickButton.new(location: button_locations[:center_location], text: label, size: [DEFAULT_BUTTON_WIDTH, DEFAULT_BUTTON_HEIGHT])
	end

	def button_primitives
		buttons.values.map { |button| button.primitives }
	end

	def button_states
		buttons.values.map { |button| button.state }
	end

	def any_true?
		buttons.values.map {|button| button.true? }.include? true
	end

	def button_is_true?(button_text)
		buttons.select { |button| button[:text] == button_text }[0].state
	end

	def assign_buttons(number_of_buttons)
		available_height = self.height - title_line_height - body_height
		available_width = self.width - SIDE_PADDING*2

		section_height = TOP_PADDING+DEFAULT_BUTTON_HEIGHT+BOTTOM_PADDING

		single_width = SIDE_PADDING*2+DEFAULT_BUTTON_WIDTH
		double_width = SIDE_PADDING*4+DEFAULT_BUTTON_WIDTH*2

		case number_of_buttons
		when 1
			self.height += section_height if available_height < section_height
			single_button
		when 2
			self.height += section_height if available_height < section_height
			self.width += double_width if available_width < double_width
			double_buttons
		when 3
			self.height += section_height if available_height < section_height
			self.width += double_width if available_width < double_width
			add_exit
			double_buttons
		else
			add_exit
		end
	end

end