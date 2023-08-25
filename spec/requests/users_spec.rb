require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    let(:user) { User.create(name: 'Lilly', posts_counter: 0) }

    it 'correct template check 1' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'placeholders in body check 1' do
      get users_path
      expect(response.body).to include('Lilly')
    end

    it 'works check' do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /user check' do
    let(:user) { User.create(name: 'Lilly', posts_counter: 0) }

    it 'correct template check 2' do
      get user_path(user.id)
      expect(response).to render_template(:show)
    end

    it 'placeholders in body check 2' do
      get user_path(user.id)
      expect(response.body).to include('Lilly')
    end

    it 'works' do
      get user_path(user.id)
      expect(response).to have_http_status(200)
    end
  end
end
