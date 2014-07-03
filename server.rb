require 'sinatra'
require_relative './lib/app.rb'


set :bind, '0.0.0.0'

enable :sessions

get '/' do
  if session[:user_id]
    user = BOOK.orm.find_user_by_id(session[:user_id])
    # other stuff

    # Display BOOK
    @book = BOOK::API.run
    @api_id = @book[:id]
    @title = @book[:title]
    @category = @book[:category]
    @authors = @book[:authors]
    @picture = @book[:picture]

    # binding.pry

    # new_book = BOOK::NewBook.run(@book)
    check = BOOK.orm.check_book(@api_id)
    if !check
      new_book = BOOK::Books.new(@api_id, @category, @title, @authors, @picture)
      new_book.create!
    end

    @pics = []
    @bookshelf = BOOK.orm.get_user_bookshelf_by_id(session[:user_id])
    @bookshelf.each do |x|
      api_id = x["api_id"]
    
      picture = BOOK.orm.get_pic_by_api(api_id)
      @pics <<picture
    end
    




    # user chooses


    # display friends
    # display score


    erb :user_home
  else
    erb :sign_in
  end
end

post '/' do
  if session[:user_id]
    @book = BOOK::API.run
    @api_id = @book[:id]
    @title = @book[:title]
    @category = @book[:category]
    @authors = @book[:authors]
    @picture = @book[:picture]

    result = BOOK::AddInterest.run(params, session)
    # @user_id = session[:user_id]



    
    redirect to '/'
    # erb :user_home
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