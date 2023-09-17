# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'
  resources :ingredients
  resources :stock_per_locations, only: %i[update]
  resources :locations
  resources :products
  resources :recipes

  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get 'calculator', to: 'calculators#index'
  post 'calculator', to: 'calculators#create'
end
