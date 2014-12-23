json.status = 200
json.agent_id @agent.id
json.agent_mac @agent.mac
json.tasking @tasks.each do |task|
	json.(task, :id, :input)
end