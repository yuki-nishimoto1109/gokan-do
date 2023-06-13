class ApplicationController < ActionController::Base
  include ApplicationHelper
  def require_login
    User.find(session[:user_id]) rescue session[:user_id] = nil
    redirect_to root_path unless session[:user_id]
  end
end
