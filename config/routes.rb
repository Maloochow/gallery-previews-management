Rails.application.routes.draw do
  match '/auth/:provider/callback', to: 'sessions#google_login', via: [:get, :post]
  get '/welcome', to: 'galleries#welcome'
  post '/welcome', to: 'galleries#login'
  resources :galleries, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :artworks
    resources :clients
    resources :users, only: [:index, :new, :create]
    resources :sessions, only: [:new, :create]
  end
  resources :sessions, only: :destroy
  resources :users, only: [:show, :edit, :update, :destroy]

  
  root 'application#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
