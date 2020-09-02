Rails.application.routes.draw do
  match '/auth/:provider/callback', to: 'sessions#google_login', via: [:get, :post]

  get '/login', to: 'sessions#new', as: "login"
  post '/login', to: 'sessions#create'

  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create'
  get '/users/:id', to: 'users#pre_gallery', as: 'user'

  post '/logout', to: 'sessions#destroy', as: 'logout'

  get '/galleries/:id/top_user', to: 'users#top', as: 'gallery_top_user'

  resources :users, only: [:edit, :update, :destroy] do
    resources :galleries, only: :create
  end

  # get '/users/user_id/galleries/new', to: 'galleries#new', as: 'new_gallery'
  # post '/users/:user_id/galleries/new', to: 'galleries#create'

  resources :galleries, only: [:show, :edit, :update, :destroy] do
    resources :artworks
    resources :clients, only: [:new, :create, :index, :show]
    resources :client_invites, only: [:edit, :update, :destroy]
    resources :user_invites, only: [:new, :create, :destroy]
    resources :users, only: [:index, :show]
  end
  
  get '/galleries/:id/enter', to: 'user_invites#enter', as: 'enter_gallery'

  root 'application#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
