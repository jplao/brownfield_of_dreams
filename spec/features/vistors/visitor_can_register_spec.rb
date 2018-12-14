require 'rails_helper'

describe 'vister can create an account', :js do
  before(:each) do
    @email = 'jimbob@aol.com'
    @first_name = 'Jim'
    @last_name = 'Bob'
    @password = 'password'

    visit '/'

    click_on 'Sign In'

    click_on 'Sign up now.'

    fill_in 'user[email]', with: @email
    fill_in 'user[first_name]', with: @first_name
    fill_in 'user[last_name]', with: @last_name
    fill_in 'user[password]', with: @password
    fill_in 'user[password_confirmation]', with: @password

    click_on'Create Account'
    expect(current_path).to eq(root_path)
  end

  it 'can create see dashboard after activating' do
    User.last.update(:activated => true)
    visit login_path
    fill_in 'session[email]', with: @email
    fill_in 'session[password]', with: @password
    click_on 'Log In'

    expect(page).to have_content(@email)
    expect(page).to have_content(@first_name)
    expect(page).to have_content(@last_name)
    expect(page).to_not have_content('Sign In')
  end

  it 'does not show dashboard if account is not activated' do
    visit login_path
    fill_in 'session[email]', with: @email
    fill_in 'session[password]', with: @password
    click_on 'Log In'
    expect(page).to have_content('Account not activated.')
    expect(page).to have_content("Check your email for the activation link.")
  end

  it 'shows error if activation link is bad' do
    user = create(:user, activated: false)
    visit edit_account_activation_path(user)
    expect(page).to have_content("Invalid activation link")
  end

  it 'shows account is activated' do
    user = create(:user, activated: false, activation_token: '12345')
    params = {email: user[:email], id: user[:activation_token]}
    visit edit_account_activation_path(params)
    expect(page).to have_content("Account activated!")
  end

  it 'does not allow you to register if email is taken' do
    visit register_path

    fill_in 'user[email]', with: @email
    fill_in 'user[first_name]', with: 'Taken'
    fill_in 'user[last_name]', with: 'Email'
    fill_in 'user[password]', with: '1234'
    fill_in 'user[password_confirmation]', with: '1234'
    click_on'Create Account'

    expect(page).to have_content('Username already exists')
    expect(current_path).to eq(register_path)
  end
end
