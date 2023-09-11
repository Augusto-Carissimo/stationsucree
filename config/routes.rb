Rails.application.routes.draw do

  root "pages#home"
  resources :ingredients
  resources :stock_per_locations, only: [:edit, :update]
  resources :locations
  resources :products
  resources :recipes


  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
end
