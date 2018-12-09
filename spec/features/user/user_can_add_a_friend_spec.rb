require 'rails_helper'

RSpec.describe 'User can add a friend' do
  it 'user can add a friend in the system' do
    user_1 = create(:user, token: ENV['GITHUB_TOKEN'])
    user_2 = create(:user, token: ENV['GITHUB_TOKEN_1'], uid: '28496818')

    VCR.use_cassette('Add_Friend', :record => :new_episodes) do
      visit '/login'

      fill_in :session_email,    with: user_1.email
      fill_in :session_password, with: user_1.password

      click_on 'Log In'

      within('#jplao.followers') do
        expect(page).to have_link('Add Friend')
      end

      within('#jplao.following') do
        expect(page).to have_link('Add Friend')
      end

      within('#averimj') do
        expect(page).to_not have_link('Add Friend')
      end

      within('#jplao.following') do
        click_on 'Add Friend'
      end

      within('.friends') do
        expect(page).to have_content(user_2.first_name)
        expect(page).to have_content(user_2.last_name)
      end
    end
  end
end
