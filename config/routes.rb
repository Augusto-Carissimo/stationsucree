Rails.application.routes.draw do
  root "pages#home"
  resources :ingredients
  resources :inventories
end
