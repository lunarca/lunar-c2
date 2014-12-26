class Nic 
	include DataMapper::Resource

	property :hw_addr, String, key: true
	property :last_ip, String

	belongs_to :agent
end