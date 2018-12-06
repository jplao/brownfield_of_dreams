require 'rails_helper'

RSpec.describe 'Github User' do
  it 'exists' do
    data = {login: 'name', url: 'http://name.com'}
    user = GithubUser.new(data)

    expect(user).to be_an_instance_of(GithubUser)
    expect(user.login).to eq('name')
    expect(user.url).to eq('http://name.com')
  end
end
