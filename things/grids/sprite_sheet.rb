require 'app/things/grids/_grid.rb'
require 'app/constants/sprite_hash.rb'
require 'app/constants/constants.rb'

SPRITESHEET = Grid.new([1000, 400], [16, 16], 16)
SPRITESHEET.highlight_mode = 0b101
SPRITESHEET.highlighter.change_color!(Color.yellow)

def SPRITESHEET.creation_data
	"%08b" % 0b00010001 # ":sprite_sheet;"
end

def SPRITESHEET.get_sprite_name
	SPRITE_HASH.key(target_cell)
end

def SPRITESHEET.sprite
	get_sprite_name
end

def SPRITESHEET.calculate_cell_location(location)
	cell_x = UnitConverter.calculate_target_cell(location[0], x)
	cell_y = UnitConverter.calculate_target_cell(location[1], y)

	cell_x = nil if cell_x < 0 || cell_x > right_side / unit_length
	cell_y = nil if cell_y < 0 || cell_y > top_side / unit_length

	[cell_x, (cell_y-15).abs]
end

def SPRITESHEET.reset_base
	self.highlighter.reset_base(location)
end

def SPRITESHEET.primitives
	[
		super,
		{
			x: x, 
			y: y, 
			w: 256, 
			h: 256, 
			tile_x: 0, 
			tile_y: 0, 
			tile_w: 256, 
			tile_h: 256, 
			path: SPRITE_PATH,
			r: 0,
			g: 0,
			b: 0,
			a: 256,
			primitive_marker: :sprite,
		}, 
		{
			x: x,
			y: y,
			w: 256,
			h: 256,
			primitive_marker: :border,
		},
		{
			x: x,
			y: y - 35,
			text: get_sprite_name,
			primitive_marker: :label,
		},
		{
			x: apex_x + 10,
			y: apex_y - 130,
			text: "Cell: %s" % target_cell.to_s,
			primitive_marker: :label,
		},
		{
			x: apex_x + 10,
			y: apex_y - 150,
			text: "Lit: %s" % target_location.to_s,#target_location.to_s,
			primitive_marker: :label,
		},
		{
			x: apex_x + 10,
			y: apex_y - 120,
			w: 128,
			h: 128,
			path: SPRITE_PATH,
			tile_x: target_location[0] - x,
			tile_y: ((target_location[1] - y) - 240).abs, # Sprite Y Axis is backwards in Dragon Ruby
			tile_w: DEFAULT_CELL_SIZE,
			tile_h: DEFAULT_CELL_SIZE,
			primitive_marker: :sprite,
		}.merge(Color.dark_blue),
	].flatten
end


