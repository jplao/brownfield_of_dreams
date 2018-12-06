require 'rails_helper'

RSpec.describe 'Dashboard Facade' do
  context 'Github API call' do
    it 'should create instances of Repository' do

        user = create(:user, token: ENV["GITHUB_TOKEN"])
        @service = GithubService.new(user.token)

        repo_data = DashboardFacade.new(user).repos

        expect(repo_data.class).to eq(Array)
        expect(repo_data[0]).to be_an_instance_of(Repository)

    end

    it 'should create instances of GithubUsers' do
        user = create(:user, token: ENV["GITHUB_TOKEN_1"])
        @service = GithubService.new(user.token)

        follower_data = DashboardFacade.new(user).followers

        expect(follower_data.class).to eq(Array)
        expect(follower_data[0]).to be_an_instance_of(GithubUser)
      
    end
  end
end
