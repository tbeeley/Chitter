class Peep

	include DataMapper::Resource
	#Makes instances of this class Datamapper resources

	property :id, 			Serial #auto-incremented
	property :message, 		String
	property :timestamp,	Time 

end

