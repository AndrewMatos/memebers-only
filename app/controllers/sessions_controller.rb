class SessionsController < ApplicationController
    include SessionsHelper
    def new
    end

    def create
    	@user = User.find_by(email: params[:session][:email])

    	if @user && @user.authenticate(params[:session][:password])
    	    log_in @user
    	    current_user
    	    redirect_to @user
        else
           flash.now[:danger]="incorrect email or password"
           render "new"
    	end
    end

	def destroy
		if logged_in?
			log_out
		end
		redirect_to root_url
	end
end
