module Sinatra
	module LunarC2
		module Routing
			module Auth
				def self.registered(app)

					app.get'/auth/login' do
						erb :login
					end

					app.post '/auth/login' do
						user = User.first(username: params['username'])
						if user.nil?
							flash[:error] = "User does not exist"
							redirect '/auth/login'
						end

						if user.authenticate params['password']
							session[:username] = user.username
							redirect '/'
						else
							flash[:error] = "Password is not correct"
							redirect '/auth/login'
						end
					end

					app.get '/auth/logout' do
						
						flash[:success] = "Successfully logged out"
						redirect '/'
					end

					app.post '/auth/unauthenticated' do
						
						flash[:error] = env['warden'].message || "You must log in"
						redirect '/auth/login'
					end

					app.get '/protected' do 
						erb :protected
					end

				end
			end
		end
	end
end