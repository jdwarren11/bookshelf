module MyApp

  class ORM

    def initialize
        @db = PG.connect(host: 'localhost', dbname: 'MY-DATABASE')
        build_tables # => Build tables upon initialization 
    end

    def build_tables
      # What tables would you like to build? 
    end

  end

  def self.orm
    @__a_instance ||= ORM.new
  end
    
end


# call ORM with: MyApp.orm.some_method