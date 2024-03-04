require 'app/input/args_object.rb'

require 'app/level_managment/level.rb'

require 'app/things/lattices/lattice.rb'
require 'app/things/lattices/sprite_sheet.rb'
require 'app/things/tiles/tile.rb'
require 'app/things/tiles/actor.rb'

require 'app/errors/error.rb'

# A class used to access game save files.

class GameFile < ArgsObject	
	include Errors

	class << self

		attr_accessor :start_index, :end_index, :raw_file_text

		@path = ""

		# This is how DragonRuby accesses game files.
		SAVEFILE_DIRECTORY = 'data/save_files/'
		SAVEFILE_EXTENSION = '.txt'

		# Generates a file path string.
		# @param file_name [String]
		# @return void
		def _generate_path(file_name)
			@path = SAVEFILE_DIRECTORY + file_name.downcase + SAVEFILE_EXTENSION
		end

		# Overwrites the chosen file with the current game's Level data.
		# @param file_name [String]
		# @return void
		def save!(file_name)
			clear!(file_name)
			_generate_path(file_name)
			_write_from_Level_export	
		end

		# Appends the creation data for every object in Level#all to the current file.
		# @return void
		def _write_from_Level_export
			Level.export.each { |e|
				_append(e.to_s)
			}
		end


		# Overwrites the current game with the selected file's data.
		# @note Thing ID numbers are not cleared when a file is unloaded.
		# @param file_name [String]
		# @return void
		def load(file_name)
			Level.delete_every!(Thing)

			_generate_path(file_name)
			@start_index = 0
			@end_index = 7

			@raw_file_text = _read(@path)
			puts end_index.class

			read_binary

		end		

		def read_binary

			until next_index_word.nil?

				case raw_file_text[start_index..end_index].to_i(2)
				when 0b00000001
					advance_stream_indexes(8, 16)
					location = [read_binary_stream]

					advance_stream_indexes(16, 16)
					location << read_binary_stream

					advance_stream_indexes(16, 16)
					size = [read_binary_stream]

					advance_stream_indexes(16, 16)
					size << read_binary_stream

					advance_stream_indexes(16, 8)
					unit = read_binary_stream

					Lattice.new(location, size, unit)

					advance_stream_indexes

				when 0b00010001
					Level.all << SPRITESHEET
					advance_stream_indexes

				when 0b00000010
					advance_stream_indexes(8, 16)
					location = [read_binary_stream]

					advance_stream_indexes(16, 16)
					location << read_binary_stream

					advance_stream_indexes(16, 16)
					size = [read_binary_stream]

					advance_stream_indexes(16, 16)
					size << read_binary_stream

					advance_stream_indexes(16, 4)
					sprite = [read_binary_stream]

					advance_stream_indexes(4, 4)
					sprite << read_binary_stream

					advance_stream_indexes(4, 8)
					color = read_binary_stream

					Tile.new(location, size, sprite).change_color!(color)

					advance_stream_indexes

				when 0b00000011

					advance_stream_indexes(8, 16)
					location = [read_binary_stream]

					advance_stream_indexes(16, 16)
					location << read_binary_stream

					advance_stream_indexes(16, 16)
					size = [read_binary_stream]

					advance_stream_indexes(16, 16)
					size << read_binary_stream

					advance_stream_indexes(16, 8)
					char = read_binary_stream

					Actor.new(location, size, char)

					advance_stream_indexes

				else
					raise InvalidTypeError, "Gamefile#load only accounts for :lattice(1), :sprite_sheet(17), tile(2) or actor(3). Found: #{raw_file_text[start_index..end_index]}"
				end

			end

		end

		def next_index_word
			raw_file_text[end_index+1]
		end

		def advance_stream_indexes(size_of_current_word = 8, size_of_next_word = 8)
			@start_index += size_of_current_word
			@end_index += size_of_next_word
		end

		def read_binary_stream
			raw_file_text[start_index..end_index].to_i(2)
		end


		# Clears the given file.
		# @param file_name [String]
		# @return void
		def clear!(file_name)
			_generate_path(file_name)
			_write("")
		end

		# Deletes the given file.
		# @note This will permanently remove the file from GameFile#all!
		# @param file_name [String]
		# @return void
		def delete!(file_name)
			_generate_path(file_name)
			@args.gtk.delete_file(@path)
		end

		# A list of files int the save_files directory.
		# @return [Array<String>]
		def all
			@args.gtk.list_files("data/save_files/")
		end

		# Checks if there is a file with the given name in #all.
		# @param file_name [String]
		# @return [Boolean]
		def exists?(file_name)
			all.include?(file_name)
		end

		# Reads the file as a large string of text.
		# @param file_path [String]
		# @return [String]
		def _read(file_path)
			@args.gtk.read_file(file_path)
		end

		# Writes a line to the file in #path.
		# @note Overwrites any existing text!
		# @param text [String]
		# @return void
		def _write(text)
			@args.gtk.write_file(@path, text)
		end

		# Appends a line to the file in #path
		# @param text [String]
		# @return void
		def _append(text)
			@args.gtk.append_file(@path, text)
		end
	end

end