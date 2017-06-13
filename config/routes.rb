# frozen_string_literal: true
Rails.application.routes.draw do
  localized do
    root to: 'pages#home'

    resources :community_events, only: []
    resources :initiatives, only: :index
    resources :our_events, only: :index
    resources :partnerships, only: :index

    get '/about' => 'pages#about', as: :about
    get '/startupfest' => 'pages#startupfest', as: :startupfest
    get '/startupfestival' => 'pages#startupfest', as: :startupfest
    get '/calendar' => 'community_events#index'
  end

  devise_for :users,
             path_names: { sign_in: 'login', sign_out: 'logout' }

  namespace :admin do
    root to: 'initiatives#index'

    resources :initiatives
    resources :partnerships
    resources :teams
    resources :member_profiles
    resources :accounts, only: [:index, :show, :edit, :update]
  end
end
