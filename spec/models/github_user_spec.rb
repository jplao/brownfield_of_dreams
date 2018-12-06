require 'rails_helper'

RSpec.describe 'Github User' do
  it 'should be a class' do
    github_user = GithubUser.new({login: "jplao", url: "https://github.com/jplao"})
    expect(github_user).to be_an_instance_of(GithubUser)
    expect(github_user.login).to eq("jplao")
    expect(github_user.url).to eq("https://github.com/jplao")
  end
end
