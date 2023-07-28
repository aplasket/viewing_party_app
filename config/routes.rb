Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"

  get "/register", to: "users#new"
  get "/dashboard", to: "users#show"
  get "/discover", to: "users#index"

  resources :movies, only: [:index, :show] do
      resources :viewing_parties, only: [:new, :create]
  end

  resources :users, only: [:create]

  get "/login", to: "users#login_form"
  post "/login", to: "users#login"
  delete "/login", to: "users#logout"
end
