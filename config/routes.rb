Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'public#index'

  namespace :account do
    get '/', to: 'dashboard#index'
    resources :users
    resource :profile, only: %i[edit update]
  end
end
