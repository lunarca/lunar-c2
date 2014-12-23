class Agent
	include DataMapper::Resource

	property :id, Serial, key: true
	property :name, String
	property :mac, String
	property :last_ip, String
	property :auth_code, BCryptHash

	property :created_at, DateTime
	property :updated_at, DateTime

	has n, :tasks

	def authenticate(attempted_code)
		if self.auth_code == attempted_code
			true
		else
			false
		end
	end
end