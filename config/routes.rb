Rails.application.routes.draw do
  # Define the homepage
  root "pages#home"  # This makes home.html.erb the homepage

  # About Page
  get "/about", to: "pages#about"

  # Health check route (optional)
  get "up" => "rails/health#show", as: :rails_health_check

  # Resources for leagues, teams, and players
  resources :leagues, only: [ :index, :show ]
  resources :teams, only: [ :index, :show ]
  resources :players, only: [ :index, :show ]
end
