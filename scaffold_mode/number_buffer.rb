module NumberBuffer
	def read_input(number)
		@number_buffer += number
	end

	def delete_previous_input!
		@number_buffer.chop!
	end

	def change_cell_size!
		self.cell_size = @number_buffer.to_i
	end
end