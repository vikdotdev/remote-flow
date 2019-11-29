Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'home#index'

  namespace :account do
    get '/', to: 'dashboard#index'
    resources :users
    resources :devices
    resource :profile, only: %i[edit update]
  end
end
