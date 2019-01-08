# frozen_string_literal: true

Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users, controllers:{
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  resources :users

  resources :friendships, only: %i[create destroy]

  resources :friend_requests, only: %i[create update destroy]

  resources :profiles, only: %i[edit update]
end
