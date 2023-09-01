class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :photo, presence: false
  validates :bio, presence: false

  validates :email, presence: true, uniqueness: true, confirmation: true

  def three_most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def email_confirmation_match
    errors.add(:email_confirmation, "doesn't match Email") if email != email_confirmation
  end

  def most_recent_posts(quant)
    posts.order(created_at: :asc).limit(quant)
  end
end
