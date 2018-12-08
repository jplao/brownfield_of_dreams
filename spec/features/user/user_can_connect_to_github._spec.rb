require 'rails_helper'

RSpec.describe 'User can connect to Github' do
  it 'sees a link to connect to github' do
    user = create(:user)
    visit login_path
    fill_in :session_email,    with: user.email
    fill_in :session_password, with: user.password
    click_on 'Log In'

    expect(current_path).to eq dashboard_path
    expect(page).to have_link('Connect to GitHub')
    expect(page).to_not have_content('Repositories')
    expect(page).to_not have_content('Following')
    expect(page).to_not have_content('Followers')
  end
end
