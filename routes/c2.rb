module Sinatra
	module LunarC2
		module Routing
			module C2
				def self.registered(app) 

					app.get '/c2/initial' do
						
					end

					app.get '/c2/checkin/:id' do

					end

					app.get '/c2/tasking/:id' do

					end

				end
			end
		end
	end
end