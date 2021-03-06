Rails.application.routes.draw do
  get 'tags/index'
  root 'pages#index'
  devise_for :users,
             controllers: {
               confirmations: 'users/confirmations',
               registrations: 'users/registrations',
               passwords: 'users/passwords',
               omniauth_callbacks: 'users/omniauth_callbacks'
             }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users do
    resource :relationships, only: %i[create destroy]
    member do
      get :follows
      get :followers
      get :favorites
      get :meal_records
      get :browsing_histories
    end

    collection { get 'search' }
  end

  resources :posts do
    resource :favorites, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
    resource :meal_records, only: %i[create destroy]
    collection do
      match 'search' => 'posts#search', via: %i[get post]
    end
  end

  resources :tags, only: %i[index show] do
    collection { get 'search' }
  end
  resources :notifications, only: :index
end
