module Routing
	module Auth
		def self.registered(app)

			app.get'/auth/login' do
				erb :login
			end

			app.post '/auth/login' do
				user = User.first(username: params['username'])
				if user.nil?
					flash[:error] = "User #{params['username']} does not exist"
					redirect '/auth/login'
				end

				if user.authenticate params['password']
					flash[:success] = "Logged in successfully"
					session[:username] = user.username
					redirect '/'
				else
					flash[:error] = "Wrong Password"
					redirect '/auth/login'
				end
			end

			app.get '/auth/logout' do
				flash[:success] = "Logged out successfully"
				session[:username] = nil
				redirect '/'
			end

			app.get '/protected' do 
				if session[:username]
					erb :protected
				else
					redirect '/'
				end
			end

		end
	end
end
