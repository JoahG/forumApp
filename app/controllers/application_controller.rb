class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :redirect_to_home
  private

  def redirect_to_home(msg)
  	redirect_to root_url, :notice => msg
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
