# frozen_string_literal: true
Rails.application.routes.draw do
  localized do
    root to: 'pages#home'

    resources :community_events, only: :index
    resources :initiatives, only: [:index, :show]
    resources :our_events, only: :index

    get '/about' => 'pages#about', as: :about
  end

  devise_for :users,
             path_names: { sign_in: 'login', sign_out: 'logout' }

  namespace :admin do
    root to: 'initiatives#index'

    resources :initiatives
    resources :organizations
    resources :teams
    resources :member_profiles
    resources :accounts, only: [:index, :show, :edit, :update]
  end
end
