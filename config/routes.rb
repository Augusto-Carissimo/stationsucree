Rails.application.routes.draw do
  root "pages#home"
  resources :ingredients, only: [:show, :new, :create]
  resources :inventories, only: [:index, :edit, :update]
  resources :stock_per_locations, only: [:edit, :update]
  resources :locations, only: [:show, :index]
end
