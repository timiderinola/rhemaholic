class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  has_many :likes, foreign_key: :fan_id, dependent: :destroy
  has_many :fans, through: :likes

  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true

  def Post.from_users_followed_by(user)
    following_ids = "SELECT leader_id FROM subscriptions
                    WHERE follower_id = :user_id"
    where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: user)
  end

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
end
