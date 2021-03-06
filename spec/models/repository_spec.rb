require 'rails_helper'

RSpec.describe 'Repository' do
  it 'should be a class' do
    repo = Repository.new({name: "Greenhouse", html_url: "https://github.com/"})
    expect(repo).to be_an_instance_of(Repository)
    expect(repo.name).to eq("Greenhouse")
    expect(repo.url).to eq("https://github.com/")
  end
end
