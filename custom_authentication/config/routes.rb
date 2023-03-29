Rails.application.routes.draw do

  root "users#root_page"
  get "/login", to: "users#login", as: "login"
  post "/login", to: "users#log_in", as: "log_in"
  get "/logout", to: "users#logout", as: "logout"
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

end
