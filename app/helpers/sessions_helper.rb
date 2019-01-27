module SessionsHelper
	def log_in(user)
		user.remember
		cookies.permanent[:token]= user.remem   
	end

	def current_user?(user)
		user == current_user
	end
    
    def current_user
    	if (token = cookies.permanent[:token])
    		@current_user ||= User.find_by(remember_token: User.digest(token))
    	end
    end

    def logged_in?
     !current_user.nil?
    end

    def log_out
		current_user.forget
		cookies.delete(:token)
		@current_user = nil   
	end

end
