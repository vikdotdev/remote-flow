Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'public#index'

  get '/pricing', to: 'public#pricing'

  namespace :account do
    get '/', to: 'dashboard#index'
    resources :users
    resources :devices
    resources :device_groups
    resource  :profile, only: %i[edit update]
    resources :organizations, except: %i[new, create]
    resources :channels
  end
end
