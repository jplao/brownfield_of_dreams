require 'rails_helper'

RSpec.describe 'Dashboard Facade' do
  context 'Github API call' do
    before(:each) do
      @user = create(:user, token: ENV["GITHUB_TOKEN"])
      @service = GithubService.new(@user.token)
    end

    it 'should create instances of Repository' do
      VCR.use_cassette("GithubService", :record => :new_episodes) do

        repo_data = DashboardFacade.new(@user).repos

        expect(repo_data.class).to eq(Array)
        expect(repo_data[0]).to be_an_instance_of(Repository)
      end
    end

    it 'should create instances of GithubUser for following' do
      VCR.use_cassette("GithubService", :record => :new_episodes) do

        user_data = DashboardFacade.new(@user).following

        expect(user_data.class).to eq(Array)
        expect(user_data[0]).to be_an_instance_of(GithubUser)
      end
    end
  end
end
