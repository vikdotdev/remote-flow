Rails.application.routes.draw do
  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq'
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  telegram_webhook TelegramBotController

  root 'public#index'

  get '/pricing', to: 'public#pricing'
  get '/about_us', to: 'public#about_us'

  get '/404', to: "errors#not_found"
  get '/500', to: "errors#internal_error"

  resources :devices,
    param: :token,
    only: %i[show],
    constraints: { token: /[a-z0-9]+/ }
  resources :accept_invites, only: %i[new create]
  resources :feedbacks, only: %i[new create]

  namespace :account do
    get '/', to: 'dashboard#index'
    get '/analytics', to: 'dashboard#analytics'

    resources :users do
      post :impersonate, on: :member
      post :stop_impersonating, on: :collection
    end

    post '/notifications/mark_all_as_read', to: 'notifications#mark_all_as_read'
    resources :devices
    resources :device_groups

    resource  :profile, only: %i[edit update] do
      patch :update_password, on: :member
    end

    resources :organizations, except: %i[new create]
    resource  :my_organization,
              only: %i[show edit update],
              controller: :my_organization

    resources :channels
    resources :contents
    resources :invites, except: %i[edit update]
    resources :feedbacks, only: %i[index destroy] do
      member do
        patch :restore
      end
    end

    resources :backgrounds, only: %i[index create destroy]
  end

  namespace :api do
    namespace :v1 do
      resource  :organization, only: :show
      resources :channels, except: %i[edit new]
      resources :contents, except: %i[edit new]
      resource :organizations, only: %i[show]
    end
  end
end
