Goodies::Application.routes.draw do

  get "sign_up" => "users#new", :as => "sign_up"
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "all_users" => "users#index", :as => "all_users"
  get "all_products" => "products#index", :as => "all_products"
  get "most_recent" => "products#most_recent", :as => "most_recent"
  get "most_popular" => "products#most_popular", :as => "most_popular"

  resources :users
  resources :sessions
  resources :products

  root :to => 'products#index'

end
