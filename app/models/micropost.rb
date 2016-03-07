class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC')}
  # mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true

  def Micropost.from_users_followed_by(user)
    following_ids = "SELECT leader_id FROM subscriptions
                    WHERE follower_id = :user_id"
    where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: user)
  end

  has_many :comments
  has_many :likes, foreign_key: :fan_id, dependent: :destroy
  has_many :fans, through: :likes


  def liked?(user)
    fans.include? user
  end

  def like!(user)
    if !liked?(user)
      fans << user
    end
  end

  def unlike!(fan)
    if liked?(user)
      fans.delete(fan)
    end
  end

  private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
