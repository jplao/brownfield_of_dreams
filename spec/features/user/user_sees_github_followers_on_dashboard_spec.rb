require 'rails_helper'

RSpec.describe 'User sees their GitHub followers on their dashboard' do
  it 'user logs in and is redirected to dashboard' do

      user = create(:user, token: ENV["GITHUB_TOKEN_1"])

      visit '/login'

      fill_in :session_email,    with: user.email
      fill_in :session_password, with: user.password

      click_on 'Log In'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("GitHub")
      expect(page).to have_css(".followers", count: 12)

  end
end
