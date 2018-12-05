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
    
    VCR.use_cassette("User_has_correct_repos") do
      user   = create(:user, token: ENV["GITHUB_TOKEN"])
      user_1 = create(:user, token: ENV["GITHUB_TOKEN_1"])

      visit '/login'

      fill_in :session_email,    with: user.email
      fill_in :session_password, with: user.password

      click_on 'Log In'

      expect(current_path).to eq('/dashboard')

      expect(page).to have_content("GitHub")
      expect(page).to have_css(".repository", count: 5)
      expect(page).to have_content('backend-curriculum-site')
      expect(page).to have_content('binary_translator')

      click_on 'Log Out'

      visit '/login'

      fill_in :session_email,    with: user_1.email
      fill_in :session_password, with: user_1.password

      click_on 'Log In'

      expect(current_path).to eq('/dashboard')
      expect(page).to_not have_content('backend-curriculum-site')
      expect(page).to_not have_content('binary_translator')

    end
  end
end
