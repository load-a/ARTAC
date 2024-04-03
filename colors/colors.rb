require 'app/colors/_color.rb'

##
# This module allows for easy color manipulation within rendered objects.
# Any object that use it must have a @color attribute that contains an hash with RGB values.
# This array is merged with the object's rendering hash to give it the desired color.
# An example of its usage is below:
# @example
# 	class Actor
# 		include Colors
# 		...etc
# 	end
# 
# 	args.state.player_sprite.change_color(Color.blue)

module Colors
	private
	attr_writer :color, :alpha

	public

	def self.test
		Color.blue
	end

	# @return [String]
	def get_color
		color[:color_name]
	end

	def get_color_id
		color[:color_id]
	end

	# @return [Void]
	def change_color!(new_color)
		if new_color.kind_of? Color or new_color.kind_of? Hash
			self.color = new_color
		elsif new_color.kind_of? Symbol
			self.color = Color.all.find {|class_color| class_color[:color_name] == new_color}
		elsif new_color.kind_of? Integer
			self.color = Color.all.find {|class_color| class_color[:color_id] == new_color}
		else 
			raise "#{new_color} is not a valid color identifier."
		end
	end

	# @return [Void]
	def save_color!
		@saved_color = @color
	end

	# @return [Void]
	def reload_color!
		change_color!(@saved_color)
	end
	alias load_color! reload_color!
	alias reset_color! reload_color!

	# @return [String]
	def saved_color
		@saved_color[:color_name]
	end

	# @return [Integer]
	def get_alpha
		@alpha
	end
	alias alpha get_alpha
	alias transparency get_alpha

	# @return [Void]
	def change_alpha!(intensity)
		@alpha = intensity
	end
	alias change_transparency! change_alpha!


	# @return [Void]
	def save_alpha! 
		@saved_alpha = @alpha
	end
	alias save_transparency! save_alpha!

	# @return [Void]
	def reload_alpha!
		@alpha = @saved_alpha
	end
	alias load_alpha! reload_alpha!
	alias reload_transparency! reload_alpha!
	alias load_transparency! reload_alpha!
end

