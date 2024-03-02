class Level
	@@all = []

	class << self
		def all
			@@all
		end

		def all_with(key, value)
			all.select { |e| e.info[key] == value }
		end

		def any_with?(key, value)
			all_with(key, value) != :none
		end	

		def all_with_type(type)
			all.select { |thing| thing.type == type }
		end
		alias all_of_type all_with_type


		def all_actors
			all_with(:type, :actor)
		end

		def all_actors_except(this)
			if this.class != Array
				all_actors.delete_if { |e| e == this }
			else
				all_actors.delete_if { |e| this.include? e }
			end
		end

		def all_actors_with(key, value)
			all_with(:type, :actor).select { |e| e.info[key] == value }
		end

		def any_actors_with?(key, value)
			all_actors_with(key, value) != []
		end

		def actor_at?(position)
			!all_actors_with(:position, position).empty?
		end


		def all_tiles
			all_with(:type, :tile)
		end

		def all_tiles_with(key, value)
			all_with(:type, :tile).select { |e| e.info[key] == value }
		end

		def any_tiles_with?(key, value)
			all_tiles_with(key, value) != []
		end

		def remove(object)
			all.reject! {|entry| entry = object}
		end


		def primitives
			# NOTE: This method is solely for `args.outputs.primitives`
			_prepare_collection.map { |e|
				e
			}
		end

		def _prepare_collection
			# NOTE: Priority shown here as top-down but `args.outputs.primitives` draws subsequent objects on top of each other
			collection = [ 
				all_with(:type, :lattice),
				all_with(:type, :highlighter),
				all_with(:type, :actor), 
				all_with(:type, :tile), 
			]

			all.each { |e| collection << e if !(collection.include? e) }
			collection.reverse.flatten
		end

		def export
			all.map { |e|
				e.creation_data
			}
		end
	end

end