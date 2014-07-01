require 'sinatra'
require_relative './lib/app.rb'


set :bind, '0.0.0.0'

enable :sessions

get '/' do
  
end