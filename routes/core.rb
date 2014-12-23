module Sinatra
	module LunarC2
		module Routing
			module Core
				def self.registered(app)

					app.get '/' do 
						if session[:username]
							@user = session[:username]
						end
						erb :home
					end

				end
			end
		end
	end
end
