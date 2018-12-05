require 'rails_helper'

RSpec.describe 'Dashboard Facade' do
  context 'Github API call' do
    it 'should create instances of Repository' do
      VCR.use_cassette("GithubService_repos") do
        user = create(:user, token: ENV["GITHUB_TOKEN"])
        @service = GithubService.new(user.token)

        repo_data = DashboardFacade.new(user).repos

        expect(repo_data.class).to eq(Array)
        expect(repo_data[0]).to be_an_instance_of(Repository)
      end
    end
  end
end
