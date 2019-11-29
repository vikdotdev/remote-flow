Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  unauthenticated do
    root 'public#index'
    get '/pricing', to: 'public#pricing'
  end

  authenticated do
    get '/', to: redirect('/account')
  end

  namespace :account do
    get '/', to: 'dashboard#index'
    resources :users
    resources :devices
    resource :profile, only: %i[edit update]
  end
end
