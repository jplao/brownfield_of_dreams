class AccountActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])
    @current_user = @user
    if @user && !@user.activated? && @user.authenticated?(params[:id])
      @user.activate
      @user.update_attribute(:activated,    true)
      @user.update_attribute(:activated_at, Time.zone.now)
      flash[:notice] = "Thank you! Your account is now activated."
      redirect_to '/dashboard'
    else
      render file: '/public/404'
    end
  end
end
