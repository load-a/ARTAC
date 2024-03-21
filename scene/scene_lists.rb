module SceneLists
	def lattices(show_visible = true)
		show_visible ? visible.select { |item| item.kind_of? Lattice } : invisible.select { |item| item.kind_of? Lattice }
	end

	def all_lattices
		extant.select { |item| item.kind_of? Lattice}
	end


	def windows(show_visible = true)
		show_visible ? visible.select { |item| item.kind_of? Window } : invisible.select { |item| item.kind_of? Window }
	end

	def all_windows
		extant.select { |item| item.kind_of? Window}
	end


	def buttons(show_visible = true)
		show_visible ? visible.select { |item| item.kind_of? Button } : invisible.select { |item| item.kind_of? Button }
	end

	def all_buttons
		extant.select { |item| item.kind_of? Button}
	end


	def tiles(show_visible = true)
		show_visible ? visible.select { |item| item.kind_of? Tile } : invisible.select { |item| item.kind_of? Tile }
	end

	def all_tiles
		extant.select { |item| item.kind_of? Tile}
	end


	def actors(show_visible = true)
		show_visible ? visible.select { |item| item.kind_of? Actor } : invisible.select { |item| item.kind_of? Actor }
	end

	def all_actors
		extant.select { |item| item.kind_of? Actor}
	end

end