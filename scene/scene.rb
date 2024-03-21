require 'app/scene/scene_lists.rb'

# Instances of this class are responsible for the existence of all entities in a scene.
# 	Add raw objects or data to each scene. It will be the caller's responsibility to extract any needed information from them.
class Scene
	include SceneLists

	private
	attr_writer :name, :visible, :invisible
	def initialize(name, all_default_objects)
		self.name = name
		self.visible = Array.new
		self.invisible = all_default_objects
	end

	public
	attr_reader :name, :visible, :invisible

	def extant
		visible + invisible
	end

	def make_visible(entity)
		return if visible.include? entity
		visible << entity
		invisible.delete entity
	end

	def make_everything_visible
		self.visible = extant
		invisible.clear
	end

	def make_invisible(entity)
		return if invisible.include? entity
		invisible << entity
		visible.delete entity
	end

	def make_everything_invisible
		self.invisible = extant
		visible.clear
	end

	def switch_state(entity)
			if visible.include?(entity)
				make_invisible(entity)
			else
				make_visible(entity)
			end
	end
	alias switch switch_state

	def delete(entity)
		visible.delete entity
		invisible.delete entity
	end

	def info
		"extant: #{extant.length} (#{visible.length}+#{invisible.length})"
	end
end