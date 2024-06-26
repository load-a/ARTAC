require 'app/_initial/threequel_alteration.rb'

require 'app/keyboard/keyboard_letters.rb'
require 'app/keyboard/keyboard_numbers.rb'
require 'app/keyboard/keyboard_directions.rb'
require 'app/keyboard/keyboard_buttons.rb'
require 'app/keyboard/keyboard_confirmations.rb'


module FullKeyboard
	include KeyboardLetters
	include KeyboardNumbers
	include KeyboardDirections
	include KeyboardButtons
	include KeyboardConfirmations

	def down_inputs
		inputs[:down].reject { |key| key == :raw_key or key.to_s.include? 'scancode' or key.to_s.include? 'char'}
	end

	def up_inputs
		inputs[:up].reject { |key| key == :raw_key or key.to_s.include? 'scancode' or key.to_s.include? 'char'}
	end

	def held_inputs
		inputs[:held].reject { |key| key == :raw_key or key.to_s.include? 'scancode' or key.to_s.include? 'char'}
	end

	def down_or_held_inputs
		inputs[:down_or_held].reject { |key| key == :raw_key or key.to_s.include? 'scancode' or key.to_s.include? 'char'}
	end

	def inputs?
		!held_inputs.empty?
	end

end
