require 'rails_helper'

RSpec.describe 'Repository' do
  it 'should be a class' do
    repo = Repository.new({name: "Greenhouse", url: "https://github.com/"})
    expect(repo).to be_an_instance_of(Repository)
  end
end
