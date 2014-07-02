require 'pry-byebug'
require 'pg'

module BOOK
  class ORM

    def initialize
        @db = PG.connect(host: 'localhost', dbname: 'bookshelf')
        build_tables # => Build tables upon initialization 
    end

    def build_tables
      # What tables would you like to build? 
      @db.exec(%Q[
        CREATE TABLE IF NOT EXISTS users (
          id serial NOT NULL PRIMARY KEY,          
          name VARCHAR(30),
          username VARCHAR(30),
          password_digest VARCHAR(100),
          score integer
        )])

      @db.exec(%Q[
        CREATE TABLE IF NOT EXISTS categories (
          id serial NOT NULL PRIMARY KEY,
          category VARCHAR(30)
          )])

      @db.exec(%Q[
        CREATE TABLE IF NOT EXISTS books (
          id serial NOT NULL PRIMARY KEY,
          api_id VARCHAR(20),
          category integer references categories(id),
          title varchar(30),
          author varchar(30),
          photo text
          )])

      @db.exec(%Q[
        CREATE TABLE IF NOT EXISTS bookshelf (
          user_id integer references users(id),
          category integer references categories(id),
          book_id integer references books(id),
          interest boolean
          )])
    end


# ============================================================
#           Categories
# ============================================================

    def add_category(category)
      response = @db.exec_params(%Q[
        INSERT INTO categories(category)
         VALUES ($1)
         RETURNING id;
         ], [category])
      response.first["id"]
    end







# ============================================================
#             BOOKS
# ============================================================
    def create_book(b_id, cat, title, author, photo)
      response = @db.exec_params(%Q[
        INSERT INTO books(book_id, category, title, author, photo)
        VALUES ($1, $2, $3, $4, $5)
        RETURNING id;
        ], [b_id, cat, title, author, photo])
    end








# ============================================================
#             USERS
# ============================================================
    def create_user(name, username, password_digest)
      response = @db.exec_params(%Q[
        INSERT INTO users(name, username, password_digest)
        VALUES ($1, $2, $3)
        RETURNING id;
        ], [name, username, password_digest])

      response.first["id"]
    end

    def find_user_by_id(id)
      result = @db.exec(%Q[
        SELECT * FROM users
        WHERE id = #{id};
        ])
      if result.num_tuples.zero?
        return nil
      else
        build_user(result.first)
      end
    end

    def build_user(attrs)
      BOOK::User.new(attrs['name'], attrs['username'], attrs['password_digest'], attrs['id'])
    end

    def get_user_by_username(username)
      result = @db.exec_params(%Q[
        SELECT * FROM users
        WHERE username = ($1);
        ], [username])

      if result.num_tuples.zero?
        return nil
      else
        build_user(result.first)
      end
    end

    def get_books_by_user_id(id)
      result = @db.exec(%Q[
        SELECT * FROM bookshelf
        WHERE user_id = ($1);
        ], [id])
    end



  end

  def self.orm
    @__db_instance ||= ORM.new
  end
    
end
