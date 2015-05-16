Rails.application.routes.draw do

  root 'mains#index'
  
  get 'profile' => 'users#profile'
  get 'logout' => 'sessions#destroy'
  
  get 'change_password' => 'users#change_password'
  post 'update_password' => 'users#update_password'

  resources :users, :posts
  resources :mains, only: [:index, :show]
  resources :sessions, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :followships, only: [:create, :destroy]

end
