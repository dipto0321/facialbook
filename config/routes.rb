# frozen_string_literal: true

Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  resources :users

  resources :friendships, only: %i[create destroy]

  resources :friend_requests, only: %i[create update destroy]
end
