RailsDevisePundit::Application.routes.draw do
  resources :horses

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end