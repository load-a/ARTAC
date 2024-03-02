require 'app/scaffold_mode/scaffold.rb'
require 'app/scaffold_mode/scaffold_interaction.rb'

def scaffold_mode args
	if Mouse.click?
		if Keyboard.letter_hold == :shift
			# Do nothing
		elsif Keyboard.letter_hold == :space
			ScaffoldInteraction::bind_scaffold_location_to_mouse_location
		else
			ScaffoldInteraction::reset_scaffold_to_mouse_location
		end

	elsif Mouse.held?
		if Keyboard.letter_hold == :space
			SCAFFOLD.adjust_location_with_difference(Mouse.location)

		else
			SCAFFOLD.calculate_size_from_reference(Mouse.location)
			SCAFFOLD.extend_non_negative_dimensions
		end

	elsif Mouse.up? or Keyboard.letter_up == :shift
		if Keyboard.letter_hold == :shift
			# Do nothing
		else
			SCAFFOLD.reposition_anchor_if_dimensions_are_negative 
			SCAFFOLD.change_anchor_to_match_location
		end
	
	end

end