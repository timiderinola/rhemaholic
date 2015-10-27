class User < ActiveRecord::Base
  before_save { self.email.downcase! }
  before_save :create_remember_token

  has_many :subscriptions, foreign_key: :follower_id, dependent: :destroy
  has_many :leaders, through: :subscriptions

  has_many :reverse_subscriptions, foreign_key: :leader_id, class_name: 'Subscription', dependent: :destroy
  has_many :followers, through: :reverse_subscriptions

  has_secure_password

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :on => :create, allow_blank: true
  validates :password_confirmation, presence: true, :on => :create

  def following?(leader)
    leaders.include? leader
  end

  def follow!(leader)
    if leader != self && !following?(leader)
      leaders << leader
    end
  end

  def unfollow!(leader)
    if leader != self && following?(leader)
      leaders.delete(leader)
    end
  end 

  def timeline_user_ids
    leader_ids + [id]
  end

  private
  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
