Rails.application.routes.draw do
  root to: "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create], controller: 'user_posts' do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create], controller: 'user_post_likes'
    end
  end

  resources :posts do
    member do
      post 'like'
    end
    resources :comments, only: [:create]
  end

  resources :user_posts, only: [:index, :show, :new, :create] do
    resources :likes, only: [:create], controller: 'user_post_likes'
  end
end
