class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :text, presence: true
  after_create :increment_posts_counter
  after_destroy :decrement_posts_counter

  scope :ordered_by_id_desc, -> { order(id: :desc) }
  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def five_most_recent_comments
    comments.order(created_at: :asc).limit(5)
  end

  def increment_posts_counter
    author.increment!(:posts_counter)
  end

  def decrement_posts_counter
    author.decrement!(:posts_counter)
  end

  def update_comments_counter
    update_column(:comments_counter, comments.count)
  end

  def update_likes_counter
    update_column(:likes_counter, likes.count)
  end
end
