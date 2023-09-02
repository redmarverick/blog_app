Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    sessions: 'users/sessions'
  }

  root to: "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy], controller: 'posts' do
      resources :comments, only: [:new, :create, :destroy]
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
