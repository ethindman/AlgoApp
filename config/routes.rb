Rails.application.routes.draw do

  root 'mains#index'
  get 'logout' => 'sessions#destroy'
  get 'search' => 'mains#show'

  resources :users, :posts
  resources :mains, only: [:index, :show]
  resources :sessions, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :followships, only: [:create, :destroy]

end
