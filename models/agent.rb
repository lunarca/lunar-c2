class Agent
	include DataMapper::Resource

	property :id, Serial, key: true
	property :name, String
	property :mac, String
	property :last_ip, String
	property :created_at, DateTime
	property :updated_at, DateTime

	has n, :tasks
end