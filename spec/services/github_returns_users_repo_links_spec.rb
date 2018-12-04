require 'rails_helper'

describe 'Github API' do
  it 'exists' do
    service = GithubService.new({username: "mmbensalah"})
    expect(service).to be_an_instance_of(GithubService)
  end

  it 'returns repository links associated with a user' do
    VCR.use_cassette("GithubService_repos") do
      service = GithubService.new({username: "mmbensalah"})
      repo_list = service.get_repositories
      expect(repo_list.class).to eq(Array)
      expect(repo_list[0][:name]).to eq("activerecord-obstacle-course")
      expect(repo_list[0][:url]).to eq("https://api.github.com/repos/mmbensalah/activerecord-obstacle-course")
    end
  end
end
