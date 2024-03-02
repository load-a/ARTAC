require 'app/buttons/button.rb'

class ToggleButton < Button
	def initialize(location, size, text = "TOGGLE BUTTON")
		super
	end

	def toggle
		@state = !@state
		resolve_color
	end

end