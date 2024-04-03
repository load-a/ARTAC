require 'app/selector/acquire.rb'
require 'app/selector/relinquish.rb'
require 'app/selector/query.rb'
require 'app/selector/stack_manipulation.rb'

class Selector
	extend Identifiable
	include Identity
	include Acquire
	include Relinquish
	include Querry
	include StackManipulation

	set_class_tag("SEL")

	attr_writer :possession, :memory, :stack

	def initialize
		set_id

		self.possession = nil	# for objects
		self.memory = nil			# for data

		self.stack = [] 			# @note Experimental: May be useful for having a permanent selection and a temporary one at the same time
	end

	public attr_reader :possession, :memory, :stack

	def info 
		{
			self: self,
			id: id_tag,
			has: @possession,
			remembers: @memory,
			stack: stack
		}
	end

	def formatted_info
		"%<id>s - h: %<has>s | r: %<remembers>s | s: %<stack>s" % info
	end

end