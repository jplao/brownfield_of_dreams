require "rails_helper"

RSpec.describe InviteNotifierMailer, type: :mailer do
    before(:each) do
      @user = create(:user)
      @invitee = {email: 'elektrafanatic@gmail.com', name: 'elektra'}
    end

    let(:mail) { InviteNotifierMailer.invite(@user, @invitee) }

    it "renders the headers" do
      expect(mail.subject).to eq('Sign up for our app.')
      expect(mail.to).to eq([@invitee[:email]])
      expect(mail.from).to eq(["noreply@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hello")
      expect(mail.body.encoded).to include('https://sheltered-sands-76845.herokuapp.com/register')
    end
  end
