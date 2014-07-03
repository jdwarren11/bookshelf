require 'unirest'

module BOOK
  class API

      def self.run
   
        begin

        categories = [ 'Philosophy', 'Art', 'Cooking', 'Technology', 'Fiction', 
                      'History', 'Law', 'Mystery', 'Politics', 'Science', 'Religion'] 
   
        cat = categories.sample
   
        url = "https://www.googleapis.com/books/v1/volumes?q=#{cat}&langRestrict=en&maxResults=10"
   
        response = Unirest.get(url, headers: { "Accept" => "application/json" })

        random = (0..10).to_a.sample

        {
        :title => response.body["items"][random]["volumeInfo"]["title"],
        :authors => response.body["items"][random]["volumeInfo"]["authors"],
        :category => categories.index(cat) + 1,
        :picture => response.body["items"][random]["volumeInfo"]["imageLinks"]["thumbnail"],
        :id => response.body["items"][random]["id"]
        }
        
        rescue
          retry

        end # begin end

    end # run end
  end # class end 
end # module end