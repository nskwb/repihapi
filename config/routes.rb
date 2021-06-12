Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root 'pages#index'
  devise_for :users, controllers: { confirmations: 'users/confirmations',
                                    registrations: 'users/registrations',
                                    passwords: 'users/passwords' }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users do
    resource :relationships, only: %i[create destroy]
    get :follows, on: :member
    get :followers, on: :member
  end
end
