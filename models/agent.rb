class Agent
	include DataMapper::Resource

	property :id, Serial, key: true
	property :name, String
	property :mac, String
	property :last_ip, String

	has n, :tasks
end