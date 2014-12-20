module Sinatra
	module LunarC2
		module Routing
			module Sessions
				def self.registered(app)

					app.get('/sessions') {
						return "Hello, Sessions"
					}

				end
			end
		end
	end
end
