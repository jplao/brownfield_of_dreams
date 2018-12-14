require 'rails_helper'

RSpec.describe "user can't visit a tutorial's show page if no videos" do
  it 'errors out' do
    user     = create(:user)
    tutorial = create(:tutorial)

    visit "/tutorials/#{tutorial.id}"

    expect(page).to have_content('Sorry, there are no videos associated with this tutorial.')
  end
end
