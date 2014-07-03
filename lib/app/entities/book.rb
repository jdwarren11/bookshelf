module BOOK
  class Books
    attr_reader :api_id, :category, :title, :authors, :photo, :id


    def initialize(api_id, category, title, authors, photo, id=nil)
      @id = id
      @api_id = api_id
      @category = category
      @title = title
      @authors = authors
      @photo = photo
    end

    def create!
      id_from_db = BOOK.orm.create_book(@api_id, @category, @title, @authors, @photo)
      @id = id_from_db
      self
    end


  end
end