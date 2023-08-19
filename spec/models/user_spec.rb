require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts).with_foreign_key('author_id') }
    it { should have_many(:comments).with_foreign_key('author_id') }
    it { should have_many(:likes) }
  end

  describe 'methods' do
    it 'returns the full name of the user' do
      user = create(:user, first_name: 'John', last_name: 'Doe')
      expect(user.full_name).to eq('John Doe')
    end

    it 'increases user posts counter when a post is created' do
      user = create(:user)
      expect {
        create(:post, author: user)
      }.to change { user.reload.posts_counter }.by(1)
    end

    it 'decreases user posts counter when a post is destroyed' do
      user = create(:user)
      post = create(:post, author: user)
      expect {
        post.destroy
      }.to change { user.reload.posts_counter }.by(-1)
    end
  end
end
