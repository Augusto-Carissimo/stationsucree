Rails.application.routes.draw do

  root "pages#home"
  resources :ingredients
  resources :inventories, only: [:index, :edit, :update]
  resources :stock_per_locations, only: [:edit, :update]
  resources :locations
  resources :products
  resources :recipes
end
