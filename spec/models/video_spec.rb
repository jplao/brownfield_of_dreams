require 'rails_helper'
RSpec.describe Video, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:position)}
  end

  describe 'relationships' do
    it {should have_many :user_videos}
    it {should have_many(:users).through(:user_videos)}
    it {should belong_to :tutorial}
  end

  describe 'class method' do
    it '#max_position' do
      tutorial = create(:tutorial)
      video    = create(:video, tutorial: tutorial)
      video_1  = create(:video, tutorial: tutorial, position: 1)
      video_2  = create(:video, tutorial: tutorial, position: 2)
      video.update_attribute(:position, nil)

      expect(video.max_position).to eq(3)
    end
  end
end
