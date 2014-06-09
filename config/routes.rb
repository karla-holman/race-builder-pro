RailsDevisePundit::Application.routes.draw do
  resources :notifications

  get 'tels/friday' => 'tels#friday'
  get 'tels/saturday' => 'tels#saturday'
  get 'tels/sunday' => 'tels#sunday'
  get 'races/update_status' => 'races#update_status'
  get 'races/menu' => 'races#menu'
  post 'races/add_winner' => 'races#add_winner'
  post 'races/scratch_horse' => 'races#scratch_horse'
  get 'races/menu/levelOne' => 'races#levelOne'
  get 'races/schedule' => 'races#schedule'

  post 'notifications/:id' => 'notifications#approve'

  get '/horses/:id/profile' => 'horses#profile'

  get 'activities/index'

  resources :tels

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