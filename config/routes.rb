Rails.application.routes.draw do
  # CORS
  match '*all' => 'application#handle_options', via: :options

  # Root
  root 'home#index'

  # Logged in
  get 'home' => 'home#home'

  # Sessions
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  # External views
  get 'signup' => 'users#new'
  get 'about' => 'home#about'
  get 'terms' => 'home#terms'
  get 'privacy' => 'home#privacy'

  # Users
  resources :users, except: [:new, :show, :edit, :update, :destroy]
  # Account activation
  resources :account_activations, only: [:edit]
  # Password resets
  resources :password_resets, only: [:new, :create, :edit, :update]

  # API Layer
  namespace :api, defaults: {format: :json}, constraints: {subdomain: 'api'}, path: '/' do
    namespace :v1 do
      # Token Authenthentication
      post '/authenticate' => 'authentication#sign_in'
      resources :books, except: [:new, :edit]
      resources :reviews, except: [:new, :edit]
      resources :comments, except: [:new, :edit]
      resources :users, only: [:update, :show, :destroy]
    end
  end

end
