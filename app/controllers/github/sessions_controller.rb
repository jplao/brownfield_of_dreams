class Github::SessionsController < ApplicationController

  def create
   auth = request.env["omniauth.auth"]
   current_user.github_connect(auth)
   redirect_to dashboard_path, :notice => "Successfully connected through GitHub"
  end

  def destroy
  end
end
