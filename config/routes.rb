Rails.application.routes.draw do
  root to: "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show], controller: 'user_posts'
  end
end