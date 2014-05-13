RailsDevisePundit::Application.routes.draw do
  resources :race_conditions

  resources :horse_conditions

  resources :horse_statuses

  resources :statuses

  resources :categories

  resources :conditions

  resources :horseraces

  resources :races

  resources :horses

  post 'horses/refresh_partial' => "horses#refresh_partial"
  get 'horses/refresh_partial' => "horses#refresh_partial"

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  resources :users do
  	resources :horses
  end

end