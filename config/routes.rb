Rails.application.routes.draw do
  resources :players
  resources :teams
  resources :tournaments
  resources :organizations
  get "/", to: "pages#index", as: :home
  get "/terms", to: "pages#terms", as: :terms
  get "/privacy", to: "pages#privacy", as: :privacy
  get "/pricing", to: "pages#pricing", as: :pricing

  resources :users
  get "profile", to: "user#profile", as: :user_profile
  get "settings", to: "user#settings", as: :user_settings
  get "settings/profile", to: "user#settings_profile", as: :user_settings_profile
  get "settings/security", to: "user#settings_security", as: :user_settings_security
  get "settings/notifications", to: "user#settings_notifications", as: :user_settings_notifications
  patch "settings/update_profile", to: "user#update_profile", as: :update_profile
  patch "settings/update_notifications", to: "user#update_notifications", as: :update_notifications

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
