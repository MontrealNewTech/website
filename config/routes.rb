# frozen_string_literal: true
Rails.application.routes.draw do
  localized do
    root to: 'pages#home'

    resources :team_members, only: :index
    resources :community_events, only: :index
    resources :contacts, only: [:new, :create]
    resources :initiatives, only: [:index, :show]

    get '/about' => 'pages#about', as: :about
  end

  devise_for :users,
             path_names: { sign_in: 'login', sign_out: 'logout' }

  namespace :admin do
    root to: 'initiatives#index'

    resources :contacts
    resources :organizations
    resources :team_members
    resources :initiatives
  end
end
