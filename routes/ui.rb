module Routing
	module UI
		def self.registered(app) 
			app.get '/agents' do
				@agents = Agent.all(order: [:updated_at.desc])
				erb :agents_list
			end

			app.get '/agents/:id' do
				@agent = Agent.first(id: params[:id])
				@tasks = Task.all(agent: @agent, order: [:created_at.desc])
				erb :agent_tasks
			end

			app.post '/agents/:id/task' do
				@agent = Agent.first(id: params[:id])
				@task = Task.create(input: params[:input], open: true, agent: @agent)
				request.accept.each do |type|
					case type
					when "text/json"
						halt jbuilder :task_created
					end
				end

				redirect "/agents/#{params[:id]}"
			end

			app.get '/agents/:id/tasks.json' do

			end
		end
	end
end
