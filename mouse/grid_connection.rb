# This module gives the mouse some extra functionality with grids.
module GridConnection
	# This method returns the first Grid the Mouse sees. It is designed to read from Level.all.
	# @note 
	def current_grid
		return unless on_any_in?
		sees_in_list.select { |thing| thing.type == :Grid }[0]
	end
	alias Grid current_grid

	def on_grid?
		!current_grid.nil?
	end

	def highlight_grid
		return unless on_grid?
		current_grid.update_highlights(location)
	end
	alias highlight highlight_grid

	def delete_tile
		# Level.all.reject! { |tile| Level.all_tiles_with(:location, Grid.target_location).include? tile }
	end

	def change_tile(sprite_name)
		# Level.all_tiles_with(:location, Grid.target_location).each { |tile| tile.change_sprite!(sprite_name) }
	end

end