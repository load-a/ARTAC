require 'app/geometry/dimensions.rb'
require 'app/geometry/perimeter.rb'

# Methods for setting an object's location in reference to another object.

module Position

	def left_of(object, padding: 10)
		object.x - self.width - padding
	end

	def put_left_of!(this, padding: 10)
		set_x!( left_of(this, padding: padding) )
	end

	def left_of?(this)
		self.x < this.x
	end


	def right_of(object, padding: 10)
		object.x + object.width + padding
	end

	def put_right_of!(this, padding: 10)
		set_x!(right_of(this, padding: padding))
	end

	def right_of?(this)
		self.x > this.x
	end


	def above(object, padding: 10)
		object.y + object.height + padding
	end

	def put_above!(this, padding: 10)
		set_y!(above(this, padding: padding))
	end

	def above?(this)
		self.y > this.y
	end


	def below(object, padding: 10)
		object.y - self.height - padding
	end

	def put_below!(this, padding: 10)
		set_y!(below(this, padding: padding))
	end

	def below?(this)
		self.y < this.y
	end


	def align_vertically_to!(this)
		self.y = this.y
	end
	alias align_vertically_with! align_vertically_to!

	def align_horizontal_to!(this)
		self.x = this.x
	end
	alias align_horizontal_with! align_horizontal_to!

	def in_row_with?(this)
		self.y == this.y
	end

	def in_column_with?(this)
		self.x == this.x
	end

end