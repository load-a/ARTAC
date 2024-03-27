# NOT FINISHED

require 'app/windows/window.rb'
require 'app/windows/window_buttons.rb'

class ButtonWindow < Window
	include WindowButtons

	def initialize(location, title, content_list, buttons = 0)
		super(location, title, content_list)
		initialize_content_sections(content_list)


	end

	def primitives
		new_primitives = super
		new_primitives.insert(1, button_primitives)
		new_primitives
	end
end