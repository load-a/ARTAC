require 'app/input/args_object.rb'
require 'app/mouse/button_connection.rb'
require 'app/mouse/grid_connection.rb'

require 'app/geometry/location'
require 'app/selector/_selector.rb'
require 'app/level_managment/_level.rb'

# An alternate way of handling mouse input.
# @note Mouse#update must be called every tick you wish to use this class.

class Mouse < ArgsObject
	extend Location
	extend GridConnection
	extend ButtonConnection

	class << self
		# (see ArgsObject#update)
		# Also updates mouse location.
		def update(args)
			super
			self.x = @args.inputs.mouse.x.to_i
			self.y = @args.inputs.mouse.y.to_i
		end

		# Checks if the Mouse was clicked.
		# @return [Boolean]
		def click?
			@args.inputs.mouse.click ? true : false
		end

		def held?
			@args.inputs.mouse.held ? true : false
		end
		alias hold? held?

		def up?
			@args.inputs.mouse.up ? true : false
		end

		# Checks if the Mouse is on anything in the given list.
		# 	Reads from Level#all by default.
		# @param list [Array<Thing>]
		# @return [Boolean]
		def on_any_in?(list)
			list.map { |thing| on?(thing) }.include? true
		end

		# Returns a list of all the objects in a given list the mouse is on.
		# 	Reads from Level#all by default.
		# @param list [Array<Thing>]
		# @return [Array<Thing>]
		def sees_in_list(list)
			list.map { |thing| thing if on?(thing) }.flatten.compact
		end
		alias sees_in sees_in_list

		def sees(list)
			sees_in_list(list)[0]
		end

		# Checks if the Mouse is on the given object.
		# @param thing [Thing]
		# @return [Boolean]
		def on?(thing)
			@args.inputs.mouse.intersect_rect? thing.rect
			
		# I cant figure out how to resolve nil errors without this. 
		# 	The console won't tell me what the specific error class is either.
		rescue
			false
		end

		# (see Thing#info)
		def info
			{
				self: "Mouse",
				location: location,
				sees: sees_in_list,
				click: click?,
				down: hold?,
				up: up?
			}
		end

		def binary_signals
			click = click? ? 1 : 0
			hold = hold? ? 1 : 0
			up = up? ? 1 : 0

			'%d%d%d' % [click, hold, up]
		end


		def formatted_info
			thing_ids = sees_in_list.map{|object| object.id}
			button_ids = sees_in_list(Button.all).map{|object| object.id}
			'L: %s, CHU: %s' % [location, binary_signals]
		end

	end
end

module MouseSelector

	@@selector = Selector.new

	def selector
		@@selector
	end

	def remember(this)
		selector.remember
	end

	def forget
		selector.forget
	end

	def take
		selector.take
	end

	def drop
		selector.drop
	end

end