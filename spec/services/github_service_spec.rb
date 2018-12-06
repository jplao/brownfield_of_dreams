require 'rails_helper'

describe 'Github API' do
  before(:each) do
    user = create(:user, token: ENV["GITHUB_TOKEN"])
    @service = GithubService.new(user.token)
  end

  it 'exists' do
    expect(@service).to be_an_instance_of(GithubService)
  end

  it 'returns repository links associated with a user' do
    VCR.use_cassette("GithubService", :record => :new_episodes) do
      repo_list = @service.get_repositories

      expect(repo_list.class).to eq(Array)
      expect(repo_list[0].keys).to include(:name)
      expect(repo_list[0].keys).to include(:url)
    end
  end

  it 'returns followers associated with a user' do
    VCR.use_cassette("GithubService", :record => :new_episodes) do
      repo_list = @service.get_followers

      expect(repo_list.class).to eq(Array)
      expect(repo_list[0].keys).to include(:login)
      expect(repo_list[0].keys).to include(:url)
    end
  end

  it 'returns Github users followed by user' do
    VCR.use_cassette("GithubService", :record => :new_episodes) do
      following_list = @service.get_following

      expect(following_list.class).to eq(Array)
      expect(following_list[0].keys).to include(:login)
      expect(following_list[0].keys).to include(:url)
    end
  end
end
