Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  namespace :account do
    get '/', to: 'dashboard#index'
    resources :users
  end
end
