require 'sinatra'
require_relative './lib/app.rb'


set :bind, '0.0.0.0'

enable :sessions

get '/' do
  if session[:user_id]
    user = BOOK.orm.find_user_by_id(session[:user_id])
    # other stuff
    erb :user_home
  else
    erb :sign_in
  end
end

post '/signup' do
  result = BOOK::SignUp.run(params)
  if result[:success?]
    session[:user_id] = result[:user_id]
    redirect to '/'
  else
    'user does not exist'
  end
end

post '/signin' do
  result = BOOK::SignIn.run(params)
  if result[:success?]
    session[:user_id] = result[:user_id]
    redirect to '/'
  else
    redirect to '/'
  end
end

post '/signout' do 
  session.clear
  redirect to '/'
end