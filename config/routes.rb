Rails.application.routes.draw do
  resources :sessions, only: [:create, :destroy]

  resources :topics
  resources :users
  resources :subjects
  resources :notifications
  resources :todo
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
