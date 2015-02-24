Rails.application.routes.draw do
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
  resources :users, except: :new
end
