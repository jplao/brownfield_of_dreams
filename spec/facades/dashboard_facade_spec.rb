require 'rails_helper'

RSpec.describe 'Dashboard Facade' do
  context 'Github API call' do
    it 'should create instances of Repository' do
      VCR.use_cassette("GithubService_repos") do
        db_facade = DashboardFacade.new
        api_data = db_facade.repos("mmbensalah")
        binding.pry
        expect(api_data.class).to eq(Array)
        expect(api_data[0]).to be_an_instance_of(Repository)
      end
    end
  end
end
@api_data

@api_data.each do |repo|
  repo.name
  repo.url
end
