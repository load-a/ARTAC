# This module gives the mouse some extra functionality with Lattices.
module LatticeConnection
	# This method returns the first Lattice the Mouse sees. It is designed to read from Level.all.
	# @note 
	def current_lattice
		return unless on_any_in?
		sees_in_list.select { |thing| thing.type == :lattice }[0]
	end
	alias lattice current_lattice

	def on_lattice?
		!current_lattice.nil?
	end

	def highlight_lattice
		return unless on_lattice?
		current_lattice.update_highlights(location)
	end
	alias highlight highlight_lattice


	def on_valid_tile?
		return false unless on_lattice?
		!Level.all_tiles_with(:location, lattice.target_location).empty?
	end
	alias on_tile? on_valid_tile?

	def current_tile
		tiles_at_current_location = Level.all_tiles_with(:location, lattice.target_location)

		raise "There are more than one Tile objects in this location." if tiles_at_current_location.length > 1

		tiles_at_current_location[0]
	end
	alias tile current_tile

	def create_tile(sprite_name)
		return unless on_lattice?
		return unless Level.all_tiles_with(:location, lattice.target_location).empty?
		Tile.new(lattice.target_location, lattice.unit_size, sprite_name)
	end

	def delete_tile
		Level.all.reject! { |tile| Level.all_tiles_with(:location, lattice.target_location).include? tile }
	end

	def change_tile(sprite_name)
		Level.all_tiles_with(:location, lattice.target_location).each { |tile| tile.change_sprite!(sprite_name) }
	end

end