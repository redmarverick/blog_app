class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  after_create :update_likes_counter
  after_destroy :update_likes_counter

  private

  def update_likes_counter
    post.update_likes_counter
  end
end
