class HomesController < ApplicationController
  def top
    redirect_to rooms_path if session[:user_id]
  end
end
