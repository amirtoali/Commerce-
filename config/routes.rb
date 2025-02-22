Rails.application.routes.draw do
  resources :posts do 
    member do
       patch "upvote", to: "posts#upvote"
       patch "downvote", to: "posts#downvote"
    end
  end
     
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  scope controller: :static do
    get :pricing
  end
  # Defines the root path route ("/")
   root "static#pricing"
   namespace :purchase do
  resources :checkouts
end
get "success", to: "checkouts#success"
resources :webhooks, only: :create
resources :billings, only: :create

resources :subscriptions
end
