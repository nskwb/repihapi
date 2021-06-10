Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users, controllers: { confirmations: 'users/confirmations',
    registrations: 'users/registrations' }
  resources :users, only: [:show]

end
