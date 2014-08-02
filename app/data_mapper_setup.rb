env = ENV["RACK_ENV"] || "development"
#we're telling datamapper to use postgres database on localhost.
DataMapper.setup(:default, "postgres://localhost/Waffle_#{env}")

require './app/models/peep'
require './app/models/user'

DataMapper.finalize
DataMapper.auto_upgrade!