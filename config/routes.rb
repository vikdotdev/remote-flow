Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  namespace :account do
    resources :admins
    resources :managers
    resources :super_admin
    resources :dashboard, only: [:index]
  end
end
