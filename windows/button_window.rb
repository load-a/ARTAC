# NOT FINISHED

require 'app/windows/window.rb'
require 'app/windows/window_buttons.rb'

class ButtonWindow < Window
	include WindowButtons

	def primitives
		new_primitives = super
		new_primitives.insert(1, button_primitives)
		new_primitives
	end
end