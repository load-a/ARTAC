class UnitConverter

	private
	attr_writer :unit

	def initialize scale_unit
		self.unit = scale_unit
	end

	public
	attr_reader :unit

	def change_unit!(_scalenew_unit)
		return if new_scale_unit == unit
		self.unit = new_scale_unit
	end

	def calculate_target_location(input, offset = 0) # => [69, 420] -> [64, 416]
	  adjustment = input - offset
	  excess = (adjustment % unit)

	  (adjustment - excess) + offset
	end

	def calculate_target_cell(input, offset = 0)
		cell = (calculate_target_location(input, offset) - offset) / unit
		cell.floor
	end

	# @note This may be removed in the future.
	def interval_to_cell(interval, origin_offset = 0) # => [64, 416] -> [4, 26]
	  (interval / unit - origin_offset / unit).floor
	end

end