RailsDevisePundit::Application.routes.draw do
  resources :condition_categories

  resources :conditions

  resources :horseraces

  resources :races

  resources :horses

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  resources :users do
  	resources :horses
  end
end