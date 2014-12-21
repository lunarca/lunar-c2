require 'bundler'
Bundler.require

# Routing files
require './routes'

# Model Files
require './models'


class LunarC2 < Sinatra::Base
	set :root, File.dirname(__FILE__)

	DataMapper.setup(:default, "sqlite://#{Dir.pwd}/development.db")

	DataMapper.finalize
	DataMapper.auto_upgrade!

	enable :sessions
	set :static, true
	set :public_folder, "#{Dir.pwd}/static"

	register Sinatra::Flash

	# Register routes
	register Sinatra::LunarC2::Routing::Sessions
	register Sinatra::LunarC2::Routing::Auth

end