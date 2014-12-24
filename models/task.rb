class Task
	include DataMapper::Resource

	property :id, Serial, key: true

	property :input, String
	property :output, String
	property :open, Boolean
	property :created_at, DateTime
	property :updated_at, DateTime

	belongs_to :agent
end