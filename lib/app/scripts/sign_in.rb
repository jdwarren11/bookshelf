module BOOK
  class SignIn

    def self.run(params)
      user = BOOK.orm.get_user_by_username( params[:username] )

      if user.nil?
        return { :success? => false, :error => :invalid_user }
      end

      password = params[:password]
      if !user.has_password?(password)
        return { :success? => false, :error => :invalid_password }
      end

      return { :success? => true, :user_id => user.id, :username => user.username}

    end
    
  end
end