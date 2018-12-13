require 'rails_helper'

RSpec.describe 'User can see tutorials' do
  it 'can only see classroom content when logged in' do
    tutorial_1, tutorial_2 = create_list(:tutorial, 2)
    tutorial_3, tutorial_4 = create_list(:tutorial, 2, classroom: true)

    visit root_path
    save_and_open_page

    expect(page).to have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)

    expect(page).not_to have_content(tutorial_3.title)
    expect(page).not_to have_content(tutorial_4.title)

    user_1 = create(:user)

    visit login_path
    fill_in :session_email,    with: user_1.email
    fill_in :session_password, with: user_1.password
    click_on 'Log In'

    visit root_path
    expect(page).to have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)
    expect(page).to have_content(tutorial_3.title)
    expect(page).to have_content(tutorial_4.title)
  end
end
