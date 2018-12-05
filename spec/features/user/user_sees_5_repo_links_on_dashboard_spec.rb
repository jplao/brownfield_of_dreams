require 'rails_helper'

feature "User logs in and is taken to their dashboard" do
  it "shows them 5 of their own GitHub repository urls" do
    VCR.use_cassette("User_to_dashboard") do
      user = create(:user, token: ENV["GITHUB_TOKEN"])

      visit '/login'

      fill_in :session_email,    with: user.email
      fill_in :session_password, with: user.password

      click_on 'Log In'

      expect(current_path).to eq('/dashboard')

      expect(page).to have_content("GitHub")
      expect(page).to have_css(".repository", count: 5)
    end
  end
end
