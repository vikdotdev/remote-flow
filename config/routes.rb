Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  unauthenticated do
    get '/', to: 'public#index'
    get '/pricing', to: 'public#pricing'
  end

  authenticated do
    get '/', to: redirect('/account')
  end

  namespace :account do
    get '/', to: 'dashboard#index'
    resources :users
    resource :profile, only: %i[edit update]
  end
end
