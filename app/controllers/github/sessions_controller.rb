class Github::SessionsController < ApplicationController

  def create
   auth = request.env["omniauth.auth"]
   session[:user_id] = current_user.id
   current_user.uid = auth["uid"]
   current_user.token = auth["credentials"]["token"]
   current_user.save
   redirect_to dashboard_path, :notice => "Successfully connected through GitHub"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
