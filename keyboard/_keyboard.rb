require 'app/input/args_object.rb'
require 'app/keyboard/input_lists.rb'
require 'app/keyboard/full_keyboard.rb'

# An alternate way of handling Keyboard input.
class Keyboard < ArgsObject
	extend InputList
	extend FullKeyboard

	class << self

		def inputs
			@args.inputs.keyboard.keys
		end
		
	end

end