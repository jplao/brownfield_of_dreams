require 'rails_helper'

RSpec.describe 'User logs in to GitHub' do
  context "using github oauth2" do
    before do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    end
    # xit 'user can log in to app and then log in through GitHub' do
    #  user = create(:user)
    #
    #  visit '/'
    #
    #  click_on "Sign In"
    #
    #  fill_in 'session[email]',    with: user.email
    #  fill_in 'session[password]', with: user.password
    #
    #  click_on 'Log In'
    #  expect(current_path).to eq(dashboard_path)
    #  expect(page).to have_link('Connect to GitHub')
    #
    #  stub_omniauth
    #  click_link 'Connect to GitHub'
    #  expect(current_path).to eq("https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT_ID']}")
  # end
   it "should successfully create a session" do
      session[:user_id].should be_nil
      post :create, provider: :github
      session[:user_id].should_not be_nil
    end
  end
end
