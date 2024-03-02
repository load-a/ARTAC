require 'app/scaffold_mode/scaffold.rb'
require 'app/mouse/mouse.rb'

module ScaffoldInteraction
	extend self

	def bind_scaffold_location_to_mouse_location
		SCAFFOLD.reset_differences!
		SCAFFOLD.calculate_difference_with_reference(Mouse.location)
	end

	def reset_scaffold_to_mouse_location
		SCAFFOLD.set_anchor! Mouse.location
		SCAFFOLD.change_location_to_match_anchor
	end
end