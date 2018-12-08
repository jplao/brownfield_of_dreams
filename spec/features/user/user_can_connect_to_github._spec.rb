require 'rails_helper'

RSpec.describe 'User can connect to Github' do
  it 'sees a link to connect to github' do
    user = create(:user)
    visit login_path
    fill_in :session_email,    with: user.email
    fill_in :session_password, with: user.password
    click_on 'Log In'

    expect(page).to have_link('Connect to GitHub')
  end
end
