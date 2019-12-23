Rails.application.routes.draw do
  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq'
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'public#index'

  get '/pricing', to: 'public#pricing'
  get '/about_us', to: 'public#about_us'

  resources :accept_invites, only: %i[new create]

  namespace :account do
    get '/', to: 'dashboard#index'
    resources :users do
      post :impersonate, on: :member
      post :stop_impersonating, on: :collection
    end
    resources :devices
    resources :device_groups
    resource  :profile, only: %i[edit update]
    resources :organizations, except: %i[new create]
    resource  :my_organization,
              only: %i[show edit update],
              controller: :my_organization
    resources :channels
    resources :contents
    resources :invites, except: %i[edit update]
  end

  namespace :api do
    namespace :v1 do
      namespace :account do
        resources :channels, only: %i[index]
      end
    end
  end
end
