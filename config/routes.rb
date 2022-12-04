Rails.application.routes.draw do
  root :to => 'main#index'
  resources :sessions, only: [:create, :destroy]

  resources :topics
  resources :user
  resources :subjects
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
