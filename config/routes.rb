# frozen_string_literal: true

Rails.application.routes.draw do

  namespace :users do
    get 'mutual_friends/index'
  end
  namespace :users do
    get 'all_friends/index'
  end
  root 'static_pages#home'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  resources :users do
    resources :all_friends, only: :index, module: :users
    resources :mutual_friends, only: :index, module: :users
    resources :posts
  end

  resources :posts do
    resources :comments, module: :posts, except: %i[index show new edit]
  end

  resources :comments, only: :edit do
    resources :comments, module: :comments, except: %i[index show new edit]
  end

  resources :friendships, only: %i[create destroy]

  resources :friend_requests, only: %i[create update destroy]

  resources :profiles, only: %i[edit update]
end
