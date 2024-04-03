module Identity

	private
	attr_writer :id

	def this_class
		self.class
	end

	def set_id
		self.id = this_class.id_counter
		this_class::increment_id_counter
	end

	public 
	attr_reader :id

	def id_tag
		'%s%02d' % [this_class.tag, self.id]
	end

end
