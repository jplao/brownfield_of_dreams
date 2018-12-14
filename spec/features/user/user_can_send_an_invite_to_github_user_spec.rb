require 'rails_helper'

RSpec.describe 'Send an invite' do
  before(:each) do
    user = create(:user, token: ENV["GITHUB_TOKEN_1"])
    visit '/login'
    fill_in :session_email,    with: user.email
    fill_in :session_password, with: user.password
    click_on 'Log In'
  end
  it 'user can send an invite to a valid github user' do

    expect(current_path).to eq('/dashboard')

    click_on 'Send an Invite'

    expect(current_path).to eq('/invite')

    fill_in :github_handle, with: 'elektrafanatic'

    click_on 'Send Invite'

    expect(current_path).to eq('/dashboard')

    expect(page).to have_content('Successfully sent invite!')
    expect(page).to_not have_content('The Github user you selected does not have an email address associated with their account.')
  end

  it 'user cannot send an invite to a non github user' do

    expect(current_path).to eq('/dashboard')

    click_on 'Send an Invite'

    expect(current_path).to eq('/invite')

    fill_in :github_handle, with: 'testestest'

    click_on 'Send Invite'

    expect(current_path).to eq('/dashboard')
    expect(page).to_not have_content('Successfully sent invite!')
    expect(page).to have_content('The Github user you selected does not have an email address associated with their account.')
  end
end
