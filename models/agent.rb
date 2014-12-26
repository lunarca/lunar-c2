class Agent
	include DataMapper::Resource

	property :id, Serial, key: true
	property :name, String
	property :auth_code, BCryptHash
	property :agent_type, String
	property :operating_system, String

	property :created_at, DateTime
	property :updated_at, DateTime

	has n, :tasks
	has n, :nics

	def authenticate(attempted_code)
		if self.auth_code == attempted_code
			true
		else
			false
		end
	end
end