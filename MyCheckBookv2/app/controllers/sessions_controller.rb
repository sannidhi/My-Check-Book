class SessionsController < ApplicationController
  
  def create
    if user = User.authenticate(params[:username], params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), :notice => "Logged in successfully."
    else
      flash.now[:alert] = "Invalid user credentials"
      redirect_to root_path
    end    
  end
  
  def destroy
    #session[:user_id] = nil
    reset_session
    redirect_to root_path, :notice => "Logged out successfully."
  end
  
end
