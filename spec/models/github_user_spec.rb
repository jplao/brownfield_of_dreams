require 'rails_helper'

RSpec.describe 'Github User' do
  it 'exists' do
    name = 'name'
    url  = 'http://name.com'
    user = GithubUser.new(name, url)

    expect(user).to be_an_instance_of(GithubUser)
    expect(user.name).to eq(name)
    expect(user.url).to eq(url)
  end
end
