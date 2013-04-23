Goodies::Application.routes.draw do

  get "sign_up" => "users#new", :as => "sign_up"
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "all_users" => "users#index", :as => "all_users"
  get "all_products" => "products#index", :as => "all_products"

  resources :users
  resources :sessions
  resources :products

  root :to => 'users#index'

end
