module BOOK
  class User
    attr_reader :id, :name, :username, :password_digest
    attr_accessor :score

    def initialize(name, username, password_digest=nil, id=nil, score=nil)
      @name = name
      @username = username
      @password_digest = password_digest
      @id = id
      @score = score
    end

    def update_password(password)
      digest = Digest::SHA1.hexdigest(password)
      @password_digest = digest
    end

    def has_password?(password)
      incoming = Digest::SHA1.hexdigest(password)
      return true if incoming == @password_digest
    end

    def create!
      id_from_db = BOOK.orm.create_user(@name, @username, @password_digest)
      @id = id_from_db
      self
    end

    def update_bookshelf
    end

  end
end
