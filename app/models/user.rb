class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :activation_digest
  before_create :create_activation_digest

  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

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

  def list_ordered_videos
    UserVideo.where(user_id: self.id)
    .joins(:video)
    .order('videos.tutorial_id asc', 'videos.position asc')
    .pluck(:title)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                 BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_activation_digest
    activation_token  = User.new_token
    activation_digest = User.digest(activation_token)
  end

end
