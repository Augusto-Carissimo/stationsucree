Rails.application.routes.draw do

  root "pages#home"
  resources :ingredients
  resources :inventories, only: [:index, :edit, :update]
  resources :stock_per_locations, only: [:edit, :update]
  resources :locations
  resources :products
  resources :recipes

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#create'
end
