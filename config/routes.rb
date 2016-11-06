Rails.application.routes.draw do
  namespace :admin do
    resources :contacts
resources :events
resources :locations
resources :organizations

    root to: "contacts#index"
  end

  root "pages#home"

  resources :events
  resources :organizations
  resources :locations
  resources :contacts, only: [:new, :create]

  get '/about' => 'pages#about', as: :about
end
