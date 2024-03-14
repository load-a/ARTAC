require 'app/buttons/click_button.rb'

module WindowButtons

	private
	
	def button_locations
		{
			:exit_location => [ x+5, apex[1]-30 ],
			:right_location => [ x+width/8, y+BOTTOM_PADDING ],
			:left_location => [ apex[0]-DEFAULT_BUTTON_WIDTH-width/8, y+BOTTOM_PADDING ],
			:center_location => [ horizontal_center-DEFAULT_BUTTON_WIDTH/2, y+BOTTOM_PADDING ],
		}
	end


	public

	def initialize_buttons(number_of_buttons)

		self.buttons = Hash.new(0)

		case number_of_buttons
		when 1
			single_button
		when 2
			double_buttons
		when 3
			add_exit
			double_buttons
		else
			add_exit
		end

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

end