class InviteController < ApplicationController
  def show
  end

  def create
    db = DashboardFacade.new(current_user)
    @info = db.github_invitee(params[:github_handle])
    invitee = { email: @info[:email], name: @info[:name] }
    if invitee[:email] != nil
      InviteNotifierMailer.invite(current_user, invitee).deliver_now
      redirect_to dashboard_path
      flash[:notice] = 'Successfully sent invite!'
    else
      flash[:notice] = 'The Github user you selected does not have an email address associated with their account.'
      redirect_to dashboard_path
    end
  end
end
