require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it {should have_many :user_videos}
    it {should have_many(:videos).through(:user_videos)}
    it {should have_many :friendships}
    it {should have_many(:friends).through(:friendships)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe '#instance methods' do
    it 'list_ordered_videos' do
      user = create(:user)
      video_1, video_2, video_3, video_4, video_5 = create_list(:video, 5)
      user_video_1 = create(:user_video, user: user, video: video_1)
      user_video_2 = create(:user_video, user: user, video: video_2)
      user_video_3 = create(:user_video, user: user, video: video_3)
      user_video_4 = create(:user_video, user: user, video: video_4)

      expect(user.list_ordered_videos).to include(video_1.title, video_2.title, video_3.title, video_4.title)
      expect(user.list_ordered_videos).to_not include(video_5.title)
    end

    it 'github_connect' do
      user = create(:user)
      expect(user.uid).to eq(nil)
      expect(user.token).to eq(nil)
      auth = { 'provider' => 'github',
                'uid' => '12345',
                'credentials' =>
                {'token' => ENV['GITHUB_TOKEN']}
              }
      user.github_connect(auth)

      expect(user.uid).to eq(auth['uid'])
      expect(user.token).to eq(ENV['GITHUB_TOKEN'])
    end
  end
end
