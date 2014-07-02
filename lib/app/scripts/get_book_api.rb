require 'unirest'

module BOOK
  class API
 
    def self.run
 
      key_words = [ 'Philosophy', 'Art', 'Cooking', 'Technology', 'Fiction', 
                    'History', 'Law', 'Mystery', 'Politics', 'Science'] 
 
      cat = key_words.sample
 
      url = "https://www.googleapis.com/books/v1/volumes?q=#{cat}&langRestrict=en&maxResults=10"
 
      response = Unirest.get(url, headers: { "Accept" => "application/json" })
 
      random = (0..9).to_a.sample
 
      {
      :title => response.body["items"][random]["volumeInfo"]["title"],
      :authors => response.body["items"][random]["volumeInfo"]["authors"],
      :category => cat,
      :picture => response.body["items"][random]["volumeInfo"]["imageLinks"]["thumbnail"],
      :id => response.body["items"][random]["id"]
      }
      
    end
  end
end