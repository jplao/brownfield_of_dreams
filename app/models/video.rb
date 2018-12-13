class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial
  validates_presence_of :position, on: :create

  def max_position
    tutorial.videos.maximum("position") + 1
  end
end
