
require 'data_mapper'
require 'sinatra' 

require_relative 'models/peep'

env = ENV["RACK_ENV"] || "development"
#we're telling datamapper to use postgres database on localhost.
DataMapper.setup(:default, "postgres://localhost/Waffle_#{env}")

require_relative './models/peep.rb'

DataMapper.finalize
#finalises the models. 

DataMapper.auto_upgrade!
#don't create the tables until they're ready. 

get '/' do
	@peeps = Peep.all 
	erb :index
end

post '/peeps' do
	message = params["message"]
	timestamp = params["timestamp"]
	peep = Peep.new(message: message, timestamp: timestamp)
	peep.timestamp = Time.now
	peep.save
	redirect to '/'
end