# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :users

  resources :friendships, only: %i[create destroy]

  resources :friend_requests, only: %i[create update destroy]
end
