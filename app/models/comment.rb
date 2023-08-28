class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_create :update_comments_counter

  private

  def update_comments_counter
    Rails.logger.info "Updating comments counter for post #{post.id}"
    post.update(comments_counter: post.comments.count)
    Rails.logger.info "Comments counter updated to #{post.comments_counter}"
  end
end
