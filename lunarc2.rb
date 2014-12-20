require 'sinatra/base'

# Routing files
require './routes'

class LunarC2 < Sinatra::Base
	set :root, File.dirname(__FILE__)

	enable :sessions

	# Register routes
	register LunarC2::Routing::Sessions
end