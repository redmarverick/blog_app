require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'methods' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    it 'increases post likes counter when a like is created' do
      expect {
        create(:like, user: user, post: post)
      }.to change { post.reload.likes_counter }.by(1)
    end

    it 'decreases post likes counter when a like is destroyed' do
      like = create(:like, user: user, post: post)
      expect {
        like.destroy
      }.to change { post.reload.likes_counter }.by(-1)
    end
  end
end
