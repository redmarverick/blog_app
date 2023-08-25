require 'rails_helper'

RSpec.describe 'UserPostsController', type: :request do
  describe 'GET /user_posts' do
    let(:user) { User.create(name: 'Lilly', posts_counter: 0) }

    it 'correct template check 1' do
      get user_posts_path(user_id: user.id)
      expect(response).to render_template(:index)
    end

    it 'placeholders in body check 1' do
      get user_posts_path(user_id: user.id)
      expect(response.body).to include('No posts yet')
    end

    it 'works check' do
      get user_posts_path(user_id: user.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /user_post check' do
    let(:user) { User.create(name: 'Lilly', posts_counter: 0) }
    let(:post) do
      Post.create(
        title: 'Random title',
        text: 'text',
        author_id: user.id,
        comments_counter: 0,
        likes_counter: 0
      )
    end

    it 'correct template check 2' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to render_template(:show)
    end

    it 'placeholders in body check 2' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response.body).to include('Random title')
    end

    it 'works check' do
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to have_http_status(200)
    end
  end
end
