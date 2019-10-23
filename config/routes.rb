Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  namespace :admin do
  resources :users
  end
  resources :tasks
  root 'tasks#index'
end
