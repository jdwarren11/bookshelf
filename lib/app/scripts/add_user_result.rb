module BOOK
  class AddInterest


    def self.run(params, session)
      u_id = session[:user_id]
      cat = params[:category]
      api_id = params[:api_id]
      interest = params[:interest]
      user_choice = BOOK.orm.add_user_result(u_id, cat, api_id, interest)


    end
  end
end