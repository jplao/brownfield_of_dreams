require 'rails_helper'

feature "User logs in and is taken to their dashboard" do
  it "shows them a list of the Github users they are following" do
    VCR.use_cassette("Github following") do
      user = create(:user, token: ENV["GITHUB_TOKEN"])

      visit '/login'

      fill_in :session_email,    with: user.email
      fill_in :session_password, with: user.password

      click_on 'Log In'

      expect(current_path).to eq('/dashboard')

      expect(page).to have_content("Following")
      expect(page).to have_css(".following")
      expect(page).to have_link('jplao')
    end
  end
end
