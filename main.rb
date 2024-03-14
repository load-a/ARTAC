# This is the way DragonRuby recommends setting up multiple file requirements.

# All basic files are 'required' here, ignoring the ones in the 'app' directory itself.
require 'app/require_file_module.rb'
require 'app/case_keys.rb'
RequireFile::require_all_ruby_files

# Set all default values here.
require 'app/initialize.rb'

# All methods that require updates should go here.
require 'app/update.rb'

# The game itself is here and must be required *last*.
require 'app/tick.rb'