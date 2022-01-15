Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :orders
  resources :stocks
  resources :products
  resources :categories
  # devise_for :users
  devise_for :users, :controller => { 
    :omniauth_callbacks => "users/omniauth_callbacks"  
  }

  get 'home/index'
  get "/cart", to: "orders#cart", as: "cart"
    
  # resources :checkouts, only: [:create]
  post '/checkout', to: "checkouts#create"
  get '/complete', to: "checkouts#complete"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"
end
