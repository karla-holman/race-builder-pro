RailsDevisePundit::Application.routes.draw do
  get 'tels/friday' => 'tels#friday'
  get 'tels/saturday' => 'tels#saturday'
  get 'tels/sunday' => 'tels#sunday'

  post 'pending_conditions/:id' => 'pending_conditions#approve'

  get '/horses/:id/profile' => 'horses#profile'

  get 'activities/index'

  resources :tels

  resources :pending_conditions

  resources :race_conditions

  resources :horse_conditions

  resources :horse_statuses

  resources :statuses

  resources :categories

  resources :conditions

  resources :horseraces

  resources :races

  resources :horses

  resources :activities

  root :to => "home#index"
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  resources :users do
  	resources :horses
  end

end