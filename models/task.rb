class Task
	include DataMapper::Resource

	property :id, Serial, key: true

	property :input, String
	property :output, String

	belongs_to :agent
end