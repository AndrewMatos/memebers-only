class ApplicationController < ActionController::Base
  include SessionsHelper
  def authorize
  	unless current_user
    flash[:danger]= "please log in"
    redirect_to login_url
  	end
  end	
end
