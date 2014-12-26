json.status = 200
json.agent_id @agent.id
json.tasking @tasks.each do |task|
	json.(task, :id, :input)
end