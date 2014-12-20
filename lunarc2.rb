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
	register Sinatra::Flash

	# Register routes
	register Sinatra::LunarC2::Routing::Sessions

	# Warden Configuration
	use Warden::Manager do |config|
		config.serialize_into_session{|user| user.id}
		config.serialize_from_session{|user| User.get(id)}

		config.scope_defaults :default,
			strategies: [:password],
			action: 'auth/unauthenticated'

		config.failure_app = self
	end

	Warden::Manager.before_failure do |env, opts|
		env['REQUEST_METHOD'] = 'POST'
	end

	Warden::Strategies.add(:password) do
		def valid?
			params['user']['username'] && params['user']['password']
		end

		def authenticate!
			user = User.first(username: params['user']['username'])
			if user.nil?
				fail!("The username you entered does not exist.")
			elsif user.authenticate(params['user']['password'])
				success!(user)
			else
				fail("Could not log in")
			end
		end
	end

end