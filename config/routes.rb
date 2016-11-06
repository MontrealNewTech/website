Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :contacts
    resources :events
    resources :locations
    resources :organizations

    root to: 'events#index'
  end

  root to: 'pages#home'

  resources :events
  resources :organizations
  resources :locations
  resources :contacts, only: [:new, :create]

  get '/about' => 'pages#about', as: :about
end
