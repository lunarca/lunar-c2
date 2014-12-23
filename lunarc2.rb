require 'bundler'
Bundler.require

# Routing files
require './routes'

# Model Files
require './models'


class LunarC2 < Sinatra::Base
	configure do
		enable :sessions

		set :root, File.dirname(__FILE__)
		set :static, true
		set :public_folder, "#{Dir.pwd}/static"
	end

	DataMapper.setup(:default, "sqlite://#{Dir.pwd}/development.db")

	DataMapper.finalize
	DataMapper.auto_upgrade!

	register Sinatra::Flash

	# Register routes
	register Sinatra::LunarC2::Routing::Sessions
	register Sinatra::LunarC2::Routing::Auth
	register Sinatra::LunarC2::Routing::Core

end