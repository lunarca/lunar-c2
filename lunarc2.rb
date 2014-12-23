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
	register Sinatra::LunarC2::Routing::C2
	register Sinatra::LunarC2::Routing::Auth
	register Sinatra::LunarC2::Routing::Core

	before do
		pass if request.path_info == "/auth/login" || request.path_info.split("/")[1] == "c2"
		if not session[:username]
			redirect "/auth/login"
		end
	end

end