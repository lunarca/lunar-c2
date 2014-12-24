module Sinatra
	module LunarC2
		module Routing
			module Core
				def self.registered(app)

					app.get '/' do 
						redirect '/agents'
					end

				end
			end
		end
	end
end
