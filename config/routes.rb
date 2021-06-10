Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'users/confirmations',
                                    registrations: 'users/registrations'}
  root 'pages#index'
end
