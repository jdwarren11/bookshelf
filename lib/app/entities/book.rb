module BOOK
  class Books


    def initialize(book_id, category, title, author, photo, id=nil)
      @id = id
      @category = category
      @title = title
      @author = author
      @photo = photo
    end

    def create!
      id_from_db = BOOK.orm.create_book(@book_id, @category, @title, @author, @photo)
      @id = id_from_db
      self
    end


  end
end