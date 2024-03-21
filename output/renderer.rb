require 'app/input/args_object.rb'
require	'app/windows/window.rb'
require 'app/things/lattices/lattice.rb'
require 'app/things/tiles/actor.rb'
require 'app/things/tiles/tile.rb'

# This class holds all the objects that are to be rendered.

class Renderer < ArgsObject
	
	@@all = []

	@@layer_order = [:background, :midground, :foreground]
	@@element_order = [:background_element, :foreground_element, :border]
	# Symbols represent classes that have not been implemented yet
	# @@class_order = [:Tooltip, Window, :Menu, Lattice, TextBlock, Actor, Tile, :Background].reverse

	class << self

		def all
			@@all
		end

		def add(object)
			return if all.include? object
			@@all << object
		end

		def remove(object)
			@@all.delete(object)
		end
		alias delete remove


		def render
			@args.outputs.primitives << parse_classes
		end

		def parse_classes(list = dig_up_arrays)
			list.map { |object|
				if object.respond_to? 'primitives'
					object.primitives
				elsif object.respond_to? 'rect'
					object.rect
				elsif object.respond_to? 'visible'
					parse_classes(object.visible)
				elsif object.kind_of? Hash
					object
				else
					puts "Not processed: " + object
				end
			}
		end

		def dig_up_arrays
			@@all.flatten
		end

	end
end