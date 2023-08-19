require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post) }
  end

  describe 'methods' do
    let(:user) { create(:user) }
    let(:post) { create(:post, author: user) }

    it 'increases post comments counter when a comment is created' do
      expect {
        create(:comment, author: user, post: post)
      }.to change { post.reload.comments_counter }.by(1)
    end

    it 'decreases post comments counter when a comment is destroyed' do
      comment = create(:comment, author: user, post: post)
      expect {
        comment.destroy
      }.to change { post.reload.comments_counter }.by(-1)
    end
  end
end
