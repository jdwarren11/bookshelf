module BOOK
  class SignUp

    def self.run(params)
      # check to see if username already exists
      user = BOOK.orm.get_user_by_username(params[:username])
      if user.nil?
        new_user = BOOK::User.new(params[:name], params[:username])
        new_user.update_password(params[:password])
        new_user.create!
        BOOK::SignIn.run(params)
      else
        false
      end
    end

  end
end