module BOOK
  class NewBook
 
    def self.run(api_hash)
      api_id = api_hash[:id]
      category = api_hash[:category]
      title = api_hash[:title]
      authors = api_hash[:authors]
      picture = api_hash[:picture]
      book = BOOK::Books.new(api_id, category, title, authors, picture)
    end
  end
end