require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:my_webapp_database.sqlite3"

require './models'

get '/' do 
	erb :home
end

get '/user' do
	erb :user
end