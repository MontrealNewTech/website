Rails.application.routes.draw do
  scope '(:locale)', locale: /en|fr/ do
    devise_for :users,
               path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

    root to: 'pages#home'

    resources :team_members, only: :index
    resources :events, only: [:index, :show]
    resources :contacts, only: [:new, :create]

    get '/about' => 'pages#about', as: :about
    namespace :admin do
      resources :contacts
      resources :events
      resources :locations
      resources :organizations
      resources :team_members

      root to: 'events#index'
    end
  end
end
