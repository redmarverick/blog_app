require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'methods' do
    let(:user) { create(:user) }

    it 'updates author posts counter after creation' do
      post = create(:post, author: user)
      expect {
        post.update_posts_counter
      }.to change { user.reload.posts_counter }.by(1)
    end

    it 'returns the five most recent comments' do
      post = create(:post)
      old_comment = create(:comment, post: post, created_at: 1.day.ago)
      recent_comments = create_list(:comment, 5, post: post, created_at: Time.current)
      expect(post.five_most_recent_comments).to eq(recent_comments)
    end

    it 'updates post likes counter' do
      post = create(:post)
      create(:like, post: post)
      expect {
        post.update_likes_counter
      }.to change { post.reload.likes_counter }.by(1)
    end
  end
end
