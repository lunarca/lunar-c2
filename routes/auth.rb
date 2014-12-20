module Sinatra
	module LunarC2
		module Routing
			module Auth
				def self.registered(app)

					app.get'/auth/login' do
						erb :login
					end

					app.post '/auth/login' do
						env['warden'].authenticate!

						flash[:success]

						if session[:return_to].nil?
							redirect '/'
						else
							redirect session[:return_to]
						end
					end

					app.get '/auth/logout' do
						env['warden'].raw_session.inspect
						env['warden'].logout
						flash[:success] = "Successfully logged out"
						redirect '/'
					end

					app.post '/auth/unauthenticated' do
						session[:return_to] = env['warden.options'][:attempted_path]
						puts env['warden.options'][:attempted_path]
						flash[:error] = env['warden'].message || "You must log in"
						redirect '/auth/login'
					end

					get '/protected' do 
						env['warden'].authenticate!
						@current_user = env['warden'].user
						erb :protected
					end

				end