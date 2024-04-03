require 'app/colors/_color.rb'
require 'app/geometry/dimensions.rb'

class ColorTable
	include Dimensions

	private

	BAR_HEIGHT = 270/9
	BAR_WIDTH = 100
	
	def initialize(location)
		self.set_location! location
	end

	public

	def light
		[
			{
				x: x,
				y: (BAR_HEIGHT*8) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.cyan),
			{
				x: x,
				y: (BAR_HEIGHT*7) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.red),
			{
				x: x,
				y: (BAR_HEIGHT*6) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.orange),
			{
				x: x,
				y: (BAR_HEIGHT*5) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.brown),
			{
				x: x,
				y: (BAR_HEIGHT*4) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.yellow),
			{
				x: x,
				y: (BAR_HEIGHT*3) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.green),
			{
				x: x,
				y: (BAR_HEIGHT*2) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.blue),
			{
				x: x,
				y: BAR_HEIGHT + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.purple),
		]
	end

	def dark
		[
			{
				x: x + BAR_WIDTH,
				y: (BAR_HEIGHT*8) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.pink),
			{
				x: x + BAR_WIDTH,
				y: (BAR_HEIGHT*7) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.dark_red),
			{
				x: x + BAR_WIDTH,
				y: (BAR_HEIGHT*6) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.dark_orange),
			{
				x: x + BAR_WIDTH,
				y: (BAR_HEIGHT*5) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.dark_brown),
			{
				x: x + BAR_WIDTH,
				y: (BAR_HEIGHT*4) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.dark_yellow),
			{
				x: x + BAR_WIDTH,
				y: (BAR_HEIGHT*3) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.dark_green),
			{
				x: x + BAR_WIDTH,
				y: (BAR_HEIGHT*2) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.dark_blue),
			{
				x: x + BAR_WIDTH,
				y: (BAR_HEIGHT*1) + y,
				w: BAR_WIDTH,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.indigo),
		]
	end

	def monochrome
		[
			{
				x: x,
				y: y,
				w: BAR_WIDTH/2,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.white),
			{
				x: x + BAR_WIDTH/2,
				y: y,
				w: BAR_WIDTH/2,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.grey),
			{
				x: x + BAR_WIDTH,
				y: y,
				w: BAR_WIDTH/2,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.black),
			{
				x: x + BAR_WIDTH*1.5,
				y: y,
				w: BAR_WIDTH/2,
				h: BAR_HEIGHT,
				primitive_marker: :solid,
			}.merge(Color.background)
		]
	end

	def rect
		{
			x: x,
			y: y,
			w: BAR_WIDTH*2,
			h: BAR_HEIGHT*9,
			primitive_marker: :border
		}
	end

	def all
		[light + dark + monochrome, rect].flatten
	end
	alias primitives all

end