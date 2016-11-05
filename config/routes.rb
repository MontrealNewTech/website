Rails.application.routes.draw do
  root "pages#home"

  resources :events
  resources :organizations
  resources :locations
end
