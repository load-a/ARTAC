require 'app/keyboard/keyboard_numerals.rb'

module KeyboardNumbers
	include KeyboardNumerals

	def number
		down_inputs.select { |number, numeral| numbers.include? number} 
	end

	def number_held
		held_inputs.select { |number, numeral| numbers.include? number }
	end
	alias number_hold number_held

	def number_up
		up_inputs.select { |number, numeral| numbers.include? number }
	end

	def number?
		numbers.any? down_or_held_inputs
	end
	alias numeral? number?

end