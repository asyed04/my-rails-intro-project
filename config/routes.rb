Rails.application.routes.draw do
  get "players/index"
  get "players/show"
  get "teams/index"
  get "teams/show"
  get "leagues/index"
  get "leagues/show"
  get "pages/about"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  get "/about", to: "pages#about"
  
  Rails.application.routes.draw do
    root "leagues#index"  # Homepage lists leagues
    resources :leagues, only: [:index, :show]
    resources :teams, only: [:index, :show]
    resources :players, only: [:index, :show]
  end
  
end
