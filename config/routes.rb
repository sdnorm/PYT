Rails.application.routes.draw do
  resources :teams
  resources :tournaments
  resources :organizations
  get "/", to: "pages#index", as: :home
  get "/terms", to: "pages#terms", as: :terms
  get "/privacy", to: "pages#privacy", as: :privacy
  get "/pricing", to: "pages#pricing", as: :pricing
  get "user/profile", to: "user#profile", as: :user_profile

  resource :registration, only: %i[ new create ]
  resource :session
  get "passwords/signed_in/edit", to: "passwords#signed_in_edit", as: :signed_in_edit_password
  patch "passwords/signed_in/update", to: "passwords#signed_in_update", as: :signed_in_update_password
  resources :passwords, param: :token, only: [ :new, :create, :edit, :update ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#index"
end
