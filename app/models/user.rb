class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def github_connect(auth)
    self.uid   = auth["uid"]
    self.token = auth["credentials"]["token"]
    self.save
  end
end
