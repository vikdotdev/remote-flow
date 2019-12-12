Rails.application.routes.draw do
  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'


  root 'public#index'

  get '/pricing', to: 'public#pricing'
  get '/about_us', to: 'public#about_us'

  resources :registrations, only: %i[new create] do
    post :accept, on: :collection
  end

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
end
