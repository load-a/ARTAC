require 'app/buttons/click_button.rb'

CLICK_BUTTON_LIST = [
	ClickButton.new(location: [53, 10], text: "create lattice"),
	ClickButton.new(text: "clear lattice"),
	ClickButton.new(text: "cell size:"),
	ClickButton.new(text: 'mode: 100'),
	ClickButton.new(location: [1120, 10], text: 'next mode' ),
	ClickButton.new(text: 'previous mode')
]

module ClickButtonList

	def commit_lattice
		CLICK_BUTTON_LIST[0]
	end

	def clear_lattice
		CLICK_BUTTON_LIST[1]
	end

	def cell_size
		CLICK_BUTTON_LIST[2]
	end

	def mode_cycle
		CLICK_BUTTON_LIST[3]
	end

	def next_mode
		CLICK_BUTTON_LIST[4]
	end

	def previous_mode
		CLICK_BUTTON_LIST[5]
	end

end

class ClickButton
	extend ClickButtonList
end