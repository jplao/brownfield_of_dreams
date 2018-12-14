class InviteNotifierMailer < ApplicationMailer
  def invite(user, invitee)
    @user = user
    @invitee = invitee
    mail(to: @invitee[:email], subject: "Sign up for our app.")
  end
end
