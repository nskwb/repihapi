Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  root 'posts#index'
  get 'posts/show'
  get 'relationships/create'
  get 'relationships/destroy'
  devise_for :users, controllers: { confirmations: 'users/confirmations',
                                    registrations: 'users/registrations',
                                    passwords: 'users/passwords' }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users do
    resource :relationships, only: %i[create destroy]
    member do
      get :follows
      get :followers
      get :favorites
    end
  end

  resources :posts do
    resource :favorites, only: %i[create destroy]
  end
end
