module Sinatra
	module LunarC2
		module Routing
			module UI
				def self.registered(app) do
					app.get '/agents' do
						@agents = Agent.all(order: [:updated_at.asc])
					end

					app.get '/agents/:id' do
						@agent = Agent.first(id: params[:id])
					end

					app.post '/agents/:id/task' do
						@agent = Agent.first(id: params[:id])
						@task = Task.create(input: params[:input], open: true, agent: @agent)
					end

					app.get '/agents/:id/tasks.json' do

					end
				end
			end
		end
	end
end