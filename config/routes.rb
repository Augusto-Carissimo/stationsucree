# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pages/home'
  get 'page/home'
  root "pages#home"
end
