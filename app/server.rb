
require 'data_mapper'
require 'sinatra' 
require 'rack-flash'

require_relative 'models/peep'
require_relative 'models/user'

require_relative './helpers/application.rb'
require_relative 'data_mapper_setup'

enable :sessions
set :session_secret, 'super secret'
set :views, Proc.new { File.join(root, "views") }
set :public_dir, Proc.new { File.join(root, "..", "public") }
use Rack::Flash
set :public_dir, Proc.new { File.join(root, "..", "public") }



get '/' do
	@peeps = Peep.all 
	erb :index, :layout => :layout
end

post '/peeps' do
	message = params["message"]
	time = params["time"]
	peep = Peep.new(message: message, time: time)
	peep.time = Time.now
	peep.save
	redirect to '/'
end

get '/users/new' do
	@user = User.new
	erb :"users/new"
end

post '/users' do
  @user = User.new(:email => params[:email], 
  			  :name => params[:name], 
  			  :username => params[:username], 
              :password => params[:password],
  			  :password_confirmation => params[:password_confirmation])
  if @user.save
	  session[:user_id] = @user.id 
	  redirect to('/')
  else
  	  flash[:errors] = @user.errors.full_messages  	  
  	  erb :'users/new'
  end
end

get '/sessions/new' do
  erb :"sessions/new"
end

post '/sessions' do
  username, password = params[:username], params[:password]
  user = User.authenticate(username, password)
  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    flash[:errors] = ["The username or password is incorrect"]
    erb :"sessions/new"
  end
end




