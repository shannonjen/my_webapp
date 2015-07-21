require 'sinatra'
require 'sinatra/activerecord'


set :database, "sqlite3:my_webapp_database.sqlite3"

require './models'

set :sessions, true

get '/' do 
  if current_user
    redirect "/user"
  else
    erb :home
  end
end

get '/signin' do
	erb :signin
end

post '/signin' do
  @user = User.where(username: params[:username]).first 
  if @user && @user.password == params[:password]
    # log in the user by setting the session[:user_id] to their ID
    session[:user_id] = @user.id
    redirect '/user'
  else
    redirect '/signin'
  end
end

#user page
get '/user' do
	@user = current_user
	if @user
		erb :user
	else
		erb :home
	end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/signin'
end

def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
end


